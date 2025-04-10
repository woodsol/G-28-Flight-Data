from glob import glob
import os

def rep(txt, vars):
    for k, v in vars.items():
        txt = txt.replace(k, v)

    return txt

def analyse(fn):
    cities = {}
    variables = {}
    drawLabelFunctions = False
    with open(fn) as f:
        for i in f.readlines():
            i = i.strip();
            if i.startswith("int "):
                var = i.split("int ")[-1].split(";")[0].split("=")
                name = var[0].strip()
                variables[name] = var[1].strip()

            if "drawLabel(" in i:
                drawLabelFunctions = True
                if "String" in i:
                    continue
                i = i.split("drawLabel(")[-1].split(")")[0].split(",")
                p1 = rep(i[1], variables)
                p2 = rep(i[2], variables)
                cities[i[0]] = [eval(p1), eval(p2)]
        
            if "text(" in i and not drawLabelFunctions:
                i = i.split("text(")[-1].split(")")[0].split(",")
                p1 = rep(i[1], variables)
                p2 = rep(i[2], variables)
                cities[i[0]] = [eval(p1), eval(p2)]
    return cities


final = ""
pimages = ""
images = ""

img_exts = [
    "jpeg",
    "jpg",
    "webp",
    "png",
    "tiff",
    "svg",
    "gif"
]

states_to_img = {}

for state in glob("States/*"):
    stateName = state.split("/")[1]
    stateName = " ".join(stateName.split("_"))
    if len(state.split('.')) > 1:
        continue

    files = glob(state+'/*')
    image = ""

    cities = {}

    for file in files:
        if file.split(".")[-1] in img_exts:
            image = file

        if file.split(".")[-1] == "pde":
            cities = analyse(file)

        if file.endswith("data"):
            for f in glob(file+"/*"):
                if f.split(".")[-1] in img_exts:
                    image = f

    pimages += "PImage "+"".join(stateName.lower().split(" "))+";\n"
    images += "".join(stateName.lower().split(" "))+" = loadImage(\"" + image + "\");\n"
    print(images)
    os.system("mv "+image+" Flight_Data/data")

    final += "temp = new HashMap<String, PVector>();\n"
    print(cities)
    for city, points in cities.items():
        final += "temp.put(" + city + ", new PVector("+str(points[0])+", "+ str(points[1]) +"));\n"
    final += "statesList.put(\""
    final += stateName + "\", new stateData("+"".join(stateName.lower().split(" "))+", temp)"
    final += ");\n"

print(final)
print(images)
