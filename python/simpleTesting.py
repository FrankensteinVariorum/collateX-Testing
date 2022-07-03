from typing import BinaryIO

from collatex import *
from xml.dom import pulldom
import re
import glob
from datetime import datetime, date
# import pytz
# from tzlocal import get_localzone

# today = date.today()
# utc_dt = datetime(today, tzinfo=pytz.utc)
# dateTime = utc_dt.astimezone(get_localzone())
# strDateTime = str(dateTime)

now = datetime.utcnow()
nowStr = str(now)

print('test: ', dir(Collation))

regexWhitespace = re.compile(r'\s+')
regexNonWhitespace = re.compile(r'\S+')
regexEmptyTag = re.compile(r'/>$')
regexBlankLine = re.compile(r'\n{2,}')
regexLeadingBlankLine = re.compile(r'^\n')
regexPageBreak = re.compile(r'<pb.+?/>')
RE_MARKUP = re.compile(r'<.+?>')
RE_PARA = re.compile(r'<p\s[^<]+?/>')
RE_INCLUDE = re.compile(r'<include[^<]*/>')
RE_MILESTONE = re.compile(r'<milestone[^<]*/>')
RE_HEAD = re.compile(r'<head[^<]*/>')
RE_AB = re.compile(r'<ab[^<]*/>')
# 2018-10-1 ebb: ampersands are apparently not treated in python regex as entities any more than angle brackets.
# RE_AMP_NSB = re.compile(r'\S&amp;\s')
# RE_AMP_NSE = re.compile(r'\s&amp;\S')
# RE_AMP_SQUISH = re.compile(r'\S&amp;\S')
# RE_AMP = re.compile(r'\s&amp;\s')
RE_AMP = re.compile(r'&')
# RE_MULTICAPS = re.compile(r'(?<=\W|\s|\>)[A-Z][A-Z]+[A-Z]*\s')
# RE_INNERCAPS = re.compile(r'(?<=hi\d"/>)[A-Z]+[A-Z]+[A-Z]+[A-Z]*')
# TITLE_MultiCaps = match(RE_MULTICAPS).lower()
RE_DELSTART = re.compile(r'<del[^<]*>')
RE_ADDSTART = re.compile(r'<add[^<]*>')
RE_MDEL = re.compile(r'<mdel[^<]*>.+?</mdel>')
RE_SHI = re.compile(r'<shi[^<]*>.+?</shi>')
RE_METAMARK = re.compile(r'<metamark[^<]*>.+?</metamark>')
RE_HI = re.compile(r'<hi\s[^<]*/>')
RE_PB = re.compile(r'<pb[^<]*/>')
RE_LB = re.compile(r'<lb.*?/>')
# 2021-09-06: ebb and djb: On <lb> collation troubles: LOOK FOR DOT MATCHES ALL FLAG
# b/c this is likely spanning multiple lines, and getting split by the tokenizing algorithm.
# 2021-09-10: ebb with mb and jc: trying .*? and DOTALL flag
RE_LG = re.compile(r'<lg[^<]*/>')
RE_L = re.compile(r'<l\s[^<]*/>')
RE_CIT = re.compile(r'<cit\s[^<]*/>')
RE_QUOTE = re.compile(r'<quote\s[^<]*/>')
RE_OPENQT = re.compile(r'“')
RE_CLOSEQT = re.compile(r'”')
RE_GAP = re.compile(r'<gap\s[^<]*/>')
# &lt;milestone unit="tei:p"/&gt;
RE_sgaP = re.compile(r'<milestone\sunit="tei:p"[^<]*/>')
# NEW REGEX PATTERNS HERE
RE_MOD = re.compile(r'<mod\s[^<]*/>')

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
# ignore = ['mod', 'add', 'sourceDoc', 'xml', 'comment', 'w', 'anchor', 'include', 'delSpan', 'addSpan', 'handShift', 'damage', 'restore', 'zone', 'surface', 'graphic', 'unclear', 'retrace']
# 2021-09-06 ebb: Let's try putting pb and lb up in ignore where I think they belong.
# 2021-09-06: ebb: NO. that's a problem because we eliminate pb and lb from the collation output,
# and we need them for location markers.
blockEmpty = ['pb', 'p', 'div', 'milestone', 'lg', 'l', 'note', 'cit', 'quote', 'bibl', 'ab', 'head']
inlineEmpty = ['lb', 'gap', 'del',  'hi', 'mod', 'add']
# 2018-05-12 (mysteriously removed but reinstated 2018-09-27) ebb: I'm setting a white space on either side of the inlineEmpty elements in line 103
# 2018-07-20: ebb: CHECK: are there white spaces on either side of empty elements in the output?
inlineContent = ['metamark', 'mdel', 'shi']
#2018-07-17 ebb: I moved the following list up into inlineEmpty, since they are all now empty elements: blockElement = ['lg', 'l', 'note', 'cit', 'quote', 'bibl']
# ebb: Tried removing 'comment', from blockElement list above, because we don't want these to be collated.

# 10-23-2017 ebb rv:

def normalizeSpace(inText):
    """Replaces all whitespace spans with single space characters"""
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
        # if event == pulldom.START_ELEMENT and node.localName in ignore:
        #    continue
        # copy comments intact
        if event == pulldom.COMMENT:
            doc.expandNode(node)
            output += node.toxml()
        # ebb: Next (below): empty block elements: pb, milestone, lb, lg, l, p, ab, head, hi,
        # We COULD set white spaces around these like this ' ' + node.toxml() + ' '
        # but what seems to happen is that the white spaces get added to tokens; they aren't used to
        # isolate the markup into separate tokens, which is really what we'd want.
        # So, I'm removing the white spaces here.
        # NOTE: Removing the white space seems to improve/expand app alignment
        elif event == pulldom.START_ELEMENT and node.localName in blockEmpty:
            output += node.toxml()
        # ebb: empty inline elements that do not take surrounding white spaces:
        elif event == pulldom.START_ELEMENT and node.localName in inlineEmpty:
            output += '\n' + node.toxml()
        # non-empty inline elements: mdel, shi, metamark
        elif event == pulldom.START_ELEMENT and node.localName in inlineContent:
            output += regexEmptyTag.sub('>', node.toxml())
        elif event == pulldom.END_ELEMENT and node.localName in inlineContent:
            output += '</' + node.localName + '>'
        # elif event == pulldom.START_ELEMENT and node.localName in blockElement:
        #    output += '\n<' + node.localName + '>\n'
        #elif event == pulldom.END_ELEMENT and node.localName in blockElement:
        #    output += '\n</' + node.localName + '>'
        elif event == pulldom.CHARACTERS:
            output += normalizeSpace(node.data)
        else:
            continue
    return output

def normalize(inputText):
# 2018-09-23 ebb THIS WORKS, SOMETIMES, BUT NOT EVERWHERE: RE_MULTICAPS.sub(format(re.findall(RE_MULTICAPS, inputText, flags=0)).title(), \
# RE_INNERCAPS.sub(format(re.findall(RE_INNERCAPS, inputText, flags=0)).lower(), \
    return RE_INCLUDE.sub('', \
        RE_AB.sub('', \
        RE_HEAD.sub('', \
        RE_AMP.sub('and', \
        RE_MDEL.sub('', \
        RE_SHI.sub('', \
        RE_HI.sub('', \
        RE_LB.sub('', \
        RE_PB.sub('', \
        RE_PARA.sub('<p/>', \
        RE_sgaP.sub('<p/>', \
        RE_MILESTONE.sub('', \
        RE_LG.sub('<lg/>', \
        RE_L.sub('<l/>', \
        RE_CIT.sub('', \
        RE_QUOTE.sub('', \
        RE_OPENQT.sub('"', \
        RE_CLOSEQT.sub('"', \
        RE_GAP.sub('', \
        RE_DELSTART.sub('<del>', \
        RE_ADDSTART.sub('<add>', \
        RE_MOD.sub('', \
        RE_METAMARK.sub('', inputText))))))))))))))))))))))).lower()

# to lowercase the normalized tokens, add .lower() to the end.
#    return regexPageBreak('',inputText)
# ebb: The normalize function makes it possible to return normalized tokens that screen out some markup, but not all.

def processToken(inputText):
    return {"t": inputText + ' ', "n": normalize(inputText)}


def processWitness(inputWitness, id):
    return {'id': id, 'tokens': [processToken(token) for token in inputWitness]}

def tokenizeFiles(name, matchString):
    with open(name, 'rb') as f1818file, \
            open('../simpleInput/1823_fullFlat_' + matchString, 'rb') as f1823file, \
            open('../simpleInput/Thomas_fullFlat_' + matchString, 'rb') as fThomasfile, \
            open('../simpleInput/1831_fullFlat_' + matchString, 'rb') as f1831file, \
            open('../simpleInput/msColl_' + matchString, 'rb') as fMSfile:
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
        return regexBlankLine.sub('\n',extract(inputFile)).split('\n')
# 2022-06-21 ebb and yxj: We think this function is what we need to modify:
# the making of tokens is problematic because it is fusing text nodes with element tags.
# Let's experiment with breaking tokens apart in other ways, maybe adding a step AFTER splitting on newlines
# to find `<.+?>` and split before and after it somehow to make sure markup is in its own token.

# 2022-07-03 yxj: The original version of tokenize function is:
# return regexLeadingBlankLine.sub('', regexBlankLine.sub('\n', extract(inputFile))).split('\n')
# I modify: 
# Remove regexLeadingBlankLine.sub() in tokenize function
# Add  '\n' before inline inlineEmpty nodes in extract function

for name in glob.glob('../simpleInput/1818_fullFlat_*'):
    try:
        matchString = name.split("fullFlat_", 1)[1]
        # ebb: above gets C30.xml for example
        # matchStr = matchString.split(".", 1)[0]
        # ebb: above strips off the file extension
        tokenLists = tokenizeFiles(name, matchString)
        collation_input = {"witnesses": tokenLists}
        # print(collation_input)
        outputFile = open('../simpleOutput/collation_' + matchString, 'w', encoding='utf-8')
        # table = collate(collation_input, output='tei', segmentation=True)
        # table = collate(collation_input, segmentation=True, layout='vertical')
        table = collate(collation_input, output='xml', segmentation=True)
        print(table)
        # print(table + '<!-- ' + nowStr + ' -->', file=outputFile)

    except IOError:
        pass



