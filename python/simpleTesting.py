from typing import BinaryIO
# 2022-07-30 ebb: We are altering this python script to handle inputs marked in a new way.
# ALL file have <note>...</note>
# Thomas edition has <add>....</add>, <del>....</del>,
# as well as <add-INNER>...</add-INNER> and <del-INNER>...</del-INNER>
# msColl edition has <sga-add sID="..""/> and <sga-add eID="..""/>: to be set in IGNORE list
# msColl edition has <del>...</del> and <del-INNER>...</del-INNER>
# msColl edition has <milestone unit="tei:p-START"/> and <milestone unit="tei:p-END"/>
# We now try to create very long tokens out of these to improve the collation alignments.
from collatex import *
from xml.dom import pulldom
import re
import glob
from datetime import datetime, date

now = datetime.utcnow()
nowStr = str(now)

print('test: ', dir(Collation))
regexHyphen = re.compile(r'\S[\‑‒–—]\S')
regexWhitespace = re.compile(r'\s+')
regexNonWhitespace = re.compile(r'\S+')
regexEmptyTag = re.compile(r'/>$')
regexBlankLine = re.compile(r'\n{2,}')
regexLeadingBlankLine = re.compile(r'^\n')
regexPageBreak = re.compile(r'<pb.+?/>', re.DOTALL)
RE_MARKUP = re.compile(r'<.+?>', re.DOTALL)
RE_WORDMARKER = re.compile(r'<w ana.+?/>')
RE_PARASTART = re.compile(r'<p\ssID.+?/>')
RE_PARAEND = re.compile(r'<p\seID.+?/>')
RE_INCLUDE = re.compile(r'<include.*?/>')
RE_HEAD = re.compile(r'<head.*?/>')
RE_AB = re.compile(r'<ab.*?/>')
# 2018-10-1 ebb: ampersands are apparently not treated in python regex as entities any more than angle brackets.
# RE_AMP_NSB = re.compile(r'\S&amp;\s')
# RE_AMP_NSE = re.compile(r'\s&amp;\S')
# RE_AMP_SQUISH = re.compile(r'\S&amp;\S')
# RE_AMP = re.compile(r'\s&amp;\s')
RE_AMP = re.compile(r'&')
RE_LT_AMP = re.compile(r'&amp;')
# RE_MULTICAPS = re.compile(r'(?<=\W|\s|\>)[A-Z][A-Z]+[A-Z]*\s')
# RE_INNERCAPS = re.compile(r'(?<=hi\d"/>)[A-Z]+[A-Z]+[A-Z]+[A-Z]*')
# TITLE_MultiCaps = match(RE_MULTICAPS).lower()
# RE_NOTE = re.compile(r'<note[^<]*?>.+?</note>', re.MULTILINE | re.DOTALL)
# RE_DEL = re.compile(r'<del[^<\-]*?>.+?</del>', re.MULTILINE | re.DOTALL)
RE_ADDSTART = re.compile(r'<add.*?>')
RE_ADDEND = re.compile(r'</add>')
RE_NOTE_START = re.compile(r'<note.*?>')
RE_NOTE_END = re.compile(r'</note>')
RE_DELSTART = re.compile(r'<del.*?>')
RE_DELEND = re.compile(r'</del>')
RE_SGA_ADDSTART = re.compile(r'<sga-add.+?sID.+?/>')
RE_SGA_ADDEND = re.compile(r'<sga-add.+?eID.+?/>')
RE_MDEL = re.compile(r'<mdel.*?>.+?</mdel>')
# RE_SHI = re.compile(r'<shi.*?>.+?</shi>')
RE_SHI_START = re.compile(r'<shi.*?>')
RE_SHI_END = re.compile(r'</shi>')
RE_METAMARK = re.compile(r'<metamark.*?>.+?</metamark>')
RE_HI = re.compile(r'<hi\s.+?/>')
RE_PB = re.compile(r'<pb.*?/>')
RE_LB = re.compile(r'<lb.*?/>')
# ebb: considered: re.DOTALL ? Probably don't need it b/c these regexes are being performed on tokens.
RE_LG = re.compile(r'<lg[^<]*/>')
RE_L = re.compile(r'<l\s[^<]*/>')
RE_CIT = re.compile(r'<cit\s[^<]*/>')
RE_QUOTE = re.compile(r'<quote\s[^<]*/>')
RE_OPENQT = re.compile(r'“')
RE_CLOSEQT = re.compile(r'”')
RE_GAP = re.compile(r'<gap\s[^<]*/>')
# &lt;milestone unit="tei:p"/&gt;
RE_sgaPSTART = re.compile(r'<milestone[^<]+?unit="tei:p-START.+?/>')
RE_sgaPEND = re.compile(r'<milestone[^<]+?unit="tei:p-END.+?/>')
RE_MILESTONE = re.compile(r'<milestone.+?>')
# 2022-07-16 amended 07-31 ebb: Milestone subbing is a special problem: In S-GA paragraphs
# are marked w/ milestone elements with @unit="tei:p"
# and also milestones are used for other things like "tei:seg""
# So we'll do a regex substitution for the paragraphs first, and THEN move to the other milestones.
RE_MOD = re.compile(r'<mod\s[^<]*/>')
RE_MULTI_LEFTANGLE = re.compile(r'<{2,}')
RE_MULTI_RIGHTANGLE = re.compile(r'>{2,}')
RE_LT_START = re.compile(r'<longToken.*?>')
RE_LT_END = re.compile(r'</longToken>')
RE_DOTDASH = re.compile(r'\.–')



# RE_DOTDASH captures a period followed by a dash, frequently seen in the S-GA edition, and not a word-dividing hyphen.
# 2022-08-08 ebb: I'm currently treating the "dotdash" as just a period for normalization to improve alignments.

# ebb: RE_MDEL = those pesky deletions of two letters or less that we want to normalize out of the collation, but preserve in the output.

# Element types: xml, div, head, p, hi, pb, note, lg, l; comment()
# Tags to ignore, with content to keep: xml, comment, anchor
# Structural elements: div, p, lg, l
# Inline elements (empty) retained in normalization: pb, milestone, xi:include
# Inline and block elements (with content) retained in normalization: note, hi, head, ab

# GIs fall into one three classes
# 2017-05-21 ebb: Due to trouble with pulldom parsing XML comments, I have converted these to comment elements,
# 2017-05-21 ebb: to be ignored during collation.
# 2017-05-30 ebb: Determined that comment elements cannot really be ignored when they have text nodes (the text is
# 2017-05-30 ebb: collated but the tags are not). Decision to make the comments into self-closing elements with text
# 2017-05-30 ebb: contents as attribute values, and content such as tags simplified to be legal attribute values.
# 2017-05-22 ebb: I've set anchor elements with @xml:ids to be the indicators of collation "chunks" to process together
ignore = ['mod', 'sourceDoc', 'xml', 'comment', 'anchor', 'include', 'delSpan', 'addSpan', 'handShift', 'damage', 'restore', 'zone', 'surface', 'graphic', 'unclear', 'retrace']
blockEmpty = ['p', 'div', 'milestone', 'lg', 'l', 'cit', 'quote', 'bibl', 'head']
inlineEmpty = ['pb', 'sga-add', 'lb', 'gap',  'hi', 'w', 'ab']
inlineContent = ['del-INNER', 'add-INNER', 'metamark', 'mdel', 'shi']
inlineVariationEvent = ['del', 'add', 'note', 'longToken']
# 10-23-2017 ebb rv:

def normalizeSpace(inText):
    """ Replaces all whitespace spans with a newline character for tokenization."""

    if regexNonWhitespace.search(inText):
        return regexWhitespace.sub('\n', inText)
    else:
        return ''

def extract(input_xml):
    """Process entire input XML document, firing on events"""
    # Start pulling; it continues automatically
    doc = pulldom.parse(input_xml)
    output = ''
    for event, node in doc:
        # elements to ignore: xml
        if event == pulldom.START_ELEMENT and node.localName in ignore:
            continue
        # copy comments intact
        # if event == pulldom.COMMENT:
        #     doc.expandNode(node)
        #     output += node.toxml()
        if event == pulldom.START_ELEMENT and node.localName in inlineVariationEvent:
            doc.expandNode(node)
            output += '\n' + node.toxml() + '\n'
        # ebb: Next (below): empty block elements: pb, milestone, lb, lg, l, p, ab, head, hi,
        # We COULD set white spaces around these like this ' ' + node.toxml() + ' '
        # but what seems to happen is that the white spaces get added to tokens; they aren't used to
        # isolate the markup into separate tokens, which is really what we'd want.
        # So, I'm removing the white spaces here.
        # NOTE: Removing the white space seems to improve/expand app alignment
        # 2022-07-16 ebb: With help from yxj, found that adding \n to each side of blockEmpty and inlineEmpty elements
        # stops the problem of forming tokens that fuse element tags to words.
        elif event == pulldom.START_ELEMENT and node.localName in blockEmpty:
            output += '\n' + node.toxml() + '\n'
        # ebb: empty inline elements that do not take surrounding white spaces:
        elif event == pulldom.START_ELEMENT and node.localName in inlineEmpty:
            output += node.toxml()
        # non-empty inline elements: mdel, shi, metamark
        elif event == pulldom.START_ELEMENT and node.localName in inlineContent:
            output += '\n' + regexEmptyTag.sub('>', node.toxml())
        elif event == pulldom.END_ELEMENT and node.localName in inlineContent:
            output += '</' + node.localName + '>' + '\n'
        # elif event == pulldom.START_ELEMENT and node.localName in blockElement:
        #    output += '\n<' + node.localName + '>\n'
        # elif event == pulldom.END_ELEMENT and node.localName in blockElement:
        #    output += '\n</' + node.localName + '>'
        elif event == pulldom.CHARACTERS:
            output += fixtoken(normalizeSpace(node.data))
        else:
            continue
    return output

def fixtoken(inText):
        # add space before and after dash and hyphen
        fixToken = re.sub('(-|[‒–—])(\S)', '\n\\1\n\\2', inText)
        fixToken = re.sub('(-|[‒–—])(\s)', '\n\\1\n\\2', fixToken)
        fixToken = re.sub('(-|[‒–—])(\S)', '\n\\1\n\\2', fixToken)
        return fixToken

def normalize(inputText):
# 2022-07-16 ebb: Adding newlines here is too late: it just inserts a newline into a token.
# 2022-08-06 ebb: I have rewritten this series of operations using a normalized variable for legibility.
# These need to run in sequence: the order of replacements matters.
# The lower() at the end lowercases all the normalized strings to simplify the comparison.

    normalized = RE_METAMARK.sub('', inputText)
 #  normalized = RE_MOD.sub('', normalized)
# <mod> is in the ignore list like anchor, etc, so why are we presuming it's being read?
    normalized = RE_GAP.sub('', normalized)
    normalized = RE_CLOSEQT.sub('"', normalized)
    normalized = RE_OPENQT.sub('"', normalized)
    normalized = RE_QUOTE.sub('', normalized)
    normalized = RE_CIT.sub('', normalized)
    normalized = RE_L.sub('<l/>', normalized)
    normalized = RE_LG.sub('<lg/>', normalized)
    normalized = RE_AB.sub('', normalized)
# 2022-08-06 <ab> wraps headings or starts of letters in the print editions
    normalized = RE_PARASTART.sub('<p-start/>', normalized)
    normalized = RE_PARAEND.sub('<p-end/>', normalized)
    normalized = RE_sgaPSTART.sub('<p-start/>', normalized)
    normalized = RE_sgaPEND.sub('<p-end/>', normalized)
    normalized = RE_MILESTONE.sub('', normalized)
    normalized = RE_PB.sub('', normalized)
    normalized = RE_LB.sub('', normalized)
    normalized = RE_NOTE_START.sub('<note_start/>', normalized)
    normalized = RE_NOTE_END.sub('<note_end/>', normalized)
    normalized = RE_SGA_ADDSTART.sub('', normalized)
    normalized = RE_SGA_ADDEND.sub('', normalized)
    normalized = RE_ADDSTART.sub('<addedThomas-start/>', normalized)
    normalized = RE_ADDEND.sub('<addedThomas-end/>', normalized)
    normalized = RE_DELSTART.sub('<delstart/>', normalized)
    normalized = RE_DELEND.sub('<delend/>', normalized)
    normalized = RE_LT_START.sub('', normalized)
    normalized = RE_LT_END.sub('', normalized)
    normalized = RE_WORDMARKER.sub('', normalized)
    normalized = RE_HI.sub('', normalized)

# 2022-08-08 ebb: Sometimes <hi> in the print editions seems irrelevant, in highlighting words at
# chapter beginnings. However, it also sometimes indicates emphasis on a word.
# Example: one or two little <hi sID="xxx"/>wives<hi eID="novel1_letter4_chapter6_div4_div6_p9_hi1"/>
# On analysis of <hi> and <shi> in the print and SG-A editions, it is difficult to distinguish
# meaningful highlights from conventional superscripts/underlining, so it seems best to ignore it in normalization,
# or return to the source texts and add markup to distinguish passages giving emphasis.
#  normalized = RE_SHI.sub('', normalized)
    normalized = RE_SHI_START.sub('', normalized)
    normalized = RE_SHI_END.sub('', normalized)
# 2022-08-08 ebb: <shi> elements mark briefly highlighted words or passages in the S-GA edition.
# The highlights themselves are not usually significant, but the text inside must be preserved for comparison.
# Example: <shi rend="underline">should be</shi>
# Previously, we were eliminating these passages entirely from the normalization, which was a serious error!
# We have not been considering highlighting or emphasis <hi> or <shi> as a significant difference in the normalization.
    normalized = RE_MDEL.sub('', normalized)
# 2022-08-08 ebb: <mdel> elements are tiny struck-out characters in the S-GA edition.
# We do not think these are significant for comparison with the other editions, so we normalize them out.
    normalized = RE_LT_AMP.sub('and', normalized)
    normalized = RE_AMP.sub('and', normalized)
    normalized = RE_DOTDASH.sub('.', normalized)
    normalized = RE_HEAD.sub('', normalized)
    normalized = RE_INCLUDE.sub('',  normalized)
    normalized = RE_MULTI_RIGHTANGLE.sub('>', normalized)
    normalized = RE_MULTI_LEFTANGLE.sub('<', normalized)
    normalized = normalized.lower()
    return normalized

def processToken(inputText):
    return {"t": inputText + ' ', "n": normalize(inputText)}


def processWitness(inputWitness, id):
    return {'id': id, 'tokens': [processToken(token) for token in inputWitness]}

def tokenizeFiles(name, matchString):
    with open(name, 'rb') as f1818file, \
            open('../collChunk-14b/1823_fullFlat_' + matchString, 'rb') as f1823file, \
            open('../collChunk-14b/Thomas_fullFlat_' + matchString, 'rb') as fThomasfile, \
            open('../collChunk-14b/1831_fullFlat_' + matchString, 'rb') as f1831file, \
            open('../collChunk-14b/msColl_' + matchString, 'rb') as fMSfile:
        f1818_tokens = tokenize(f1818file)
        f1823_tokens = tokenize(f1823file)
        fThomas_tokens = tokenize(fThomasfile)
        f1831_tokens = tokenize(f1831file)
        fMS_tokens = tokenize(fMSfile)

        f1818_tokenlist = processWitness(f1818_tokens, 'f1818')
        fThomas_tokenlist = processWitness(fThomas_tokens, 'fThomas')
        f1823_tokenlist = processWitness(f1823_tokens, 'f1823')
        f1831_tokenlist = processWitness(f1831_tokens, 'f1831')
        fMS_tokenlist = processWitness(fMS_tokens, 'fMS')

        return [f1818_tokenlist, f1823_tokenlist, fThomas_tokenlist, f1831_tokenlist, fMS_tokenlist]


def tokenize(inputFile):
        return regexLeadingBlankLine.sub('\n', regexBlankLine.sub('\n', extract(inputFile))).split('\n')
# 2022-06-21 ebb and yxj: We think this function is what we need to modify:
# the making of tokens is problematic because it is fusing text nodes with element tags.
# Let's experiment with breaking tokens apart in other ways, maybe adding a step AFTER splitting on newlines
# to find `<.+?>` and split before and after it somehow to make sure markup is in its own token.

# 2022-07-03 yxj: modify extract function:
# declare a list inlineAdd for <add>
# add  '\n' before <add> nodes in extract function

for name in glob.glob('../collChunk-14b/1818_fullFlat_*'):
    try:
        matchString = name.split("fullFlat_", 1)[1]
        # ebb: above gets C30.xml for example
        # matchStr = matchString.split(".", 1)[0]
        # ebb: above strips off the file extension
        tokenLists = tokenizeFiles(name, matchString)
        collation_input = {"witnesses": tokenLists}
        # print(collation_input)
        outputFile = open('../simpleOutput/Collation_' + matchString, 'w', encoding='utf-8')
        # table = collate(collation_input, output='tei', segmentation=True)
        # table = collate(collation_input, segmentation=True, layout='vertical')
        table = collate(collation_input, output='xml', segmentation=True)
        print(table)
        print(table + '<!-- ' + nowStr + ' -->', file=outputFile)

    except IOError:
        pass



