import re

str = 'a-b - c—d'

print(re.sub('(\S)(-|[‒–—])(\S)', '\1\n\2\n\3', str))



# return re.sub('(\S)([\‑‒–—])(\S)', '\\1\n\\2\n\\3', inText)