from xml.etree import ElementTree
import re

FORMAT_REF = "fr_FR"
TAG_REGEX = re.compile(r"Tag=['\"](.+?)['\"]\s*Language=['\"](.+?)['\"]>")
TEXT_REGEX = re.compile(r"<Text>(.+)</Text>")

def get_text(tag, et) -> str:
    root = et.getroot()
    for i in root[0]:
        if i.attrib['Tag'] == tag:
            return i[0].text
    return None

def main():
    # Load File
    with open("../lang/french.xml", 'r', encoding='utf-8') as fd:
        fr = fd.read()
    et = ElementTree.parse("../lang/english.xml")

    result = []
    mem_tag = None
    for line in fr.split('\n'):
        if not line:
            continue
        tags = TAG_REGEX.findall(line)
        if tags:
            mem_tag = tags[0][0]
            line = line.replace('fr_FR', 'en_US')
            result.append(line)
            continue
        texts = TEXT_REGEX.findall(line)
        if texts:
            txt = get_text(mem_tag, et)
            if not txt:
                t = line.split('>', 1)[1].rsplit('<', 1)[0]
                txt = f'[COLOR_RED]MISSING TRAD: {t}[ENDCOLOR]'
            line = f"\t\t\t<Text>{txt}</Text>"
            result.append(line)
            continue
        result.append(line)

    print("number of lines:", len(result))
    final_result = '\n'.join(result)
    print("number of char", len(final_result))
    fd = open("../lang/new_english.xml", 'w', encoding="utf-8")
    fd.write(final_result)
    fd.close()
    return None


if __name__ == '__main__':
    main()
