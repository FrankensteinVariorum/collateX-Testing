import simpleTesting
from nose.tools import assert_equal
# def test_evens():
#     for i in range(0, 5):
#         yield check_even, i, i*3
# def check_even(n, nn):
#     assert n % 2 == 0 or nn % 2 == 0

# def test_normalizeSpace():
#     assert_equal()

def test_processToken():
    assert_equal({'t': 'and ', 'n': 'and'}, simpleTesting.processToken("and"))

def test_normalize():
    assert_equal("and",simpleTesting.normalize("&amp;amp;"))
    assert_equal("or", simpleTesting.normalize("&amp;"), "Function normalize() failed!")

def test_extract():
    assert_equal("\n<del rend=\"strikethrough\" xml:id=\"c56-0105__main__d5e22055\">\"</del>\n"
                 "<longToken>must die –</longToken>"
                 , simpleTesting.extract("test.xml"))

def test_fixtoken():
    assert_equal("This\n-\nis\n‒\na \n–\ntest \n—\nstring.", simpleTesting.fixtoken("This-is‒a –test —string."))