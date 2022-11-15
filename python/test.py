import simpleTesting
from nose.tools import *

testFile = "testFiles/test.xml"


def test_normalizeSpace():
    """ Replaces all whitespace spans with a newline character for tokenization."""
    assert_equal("", simpleTesting.normalizeSpace(" \n    "))
    assert_equal("\n?\n", simpleTesting.normalizeSpace(" \n   ? "))
    assert_equal("Hi!\n", simpleTesting.normalizeSpace("Hi! \n    "))
    assert_equal("Hello,\nworld\n!", simpleTesting.normalizeSpace("Hello,\n world   !"))


def test_extract():
    assert_equal("\n<del rend=\"strikethrough\" xml:id=\"c56-0105__main__d5e22055\">\"</del>\n"
                 "<longToken>must die –</longToken>"
                 , simpleTesting.extract(testFile))


def test_fixToken():
    """ Add space before and after dash and hyphen """
    assert_equal("This\n-\nis\n‒\na \n–\ntest \n—\nstring.", simpleTesting.fixToken("This-is‒a –test —string."))


def test_normalize():
    assert_equal("and", simpleTesting.normalize("&amp;amp;"))


def test_processToken():
    assert_dict_equal({'t': 'and ', 'n': 'and'}, simpleTesting.processToken("and"))

def test_processWitness():
    inputWitness = "and"
    id = "and"
    assert_dict_equal({'id': 'and', 'tokens': [{'t': 'a ', 'n': 'a'}, {'t': 'n ', 'n': 'n'}, {'t': 'd ', 'n': 'd'}]},
                 simpleTesting.processWitness(inputWitness, id))

def test_tokenize():
    test = open(testFile, "rb")
    assert_list_equal(['', '<del rend="strikethrough" xml:id="c56-0105__main__d5e22055">"</del>',
                  '<longToken>must', 'die', '–</longToken>', ''], simpleTesting.tokenize(test))

# def test_tokenizeFiles():




