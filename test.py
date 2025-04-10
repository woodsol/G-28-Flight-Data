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
    size = [1000, 600]
    with open(fn) as f:
        for i in f.readlines():
            i = i.strip();
            if i.startswith("size("):
                t = i.split("(")[-1].split(")")[0].split(",")
                size[0] = int(t[0])
                size[1] = int(t[1])
            if i.startswith("image("):
                t = i.split("(")[-1].split(")")[0].split(",")
                print(t)
                size[0] = eval(t[3].replace("width", str(size[0])))
                size[1] = eval(t[4].replace("height", str(size[1])))
            if i.startswith("int "):
                var = i.split("int ")[-1].split(";")[0].split("=")
                name = var[0].strip()
                variables[name] = var[1].strip()
                if "x" in name.lower():
                    variables[name] = str(float(variables[name]) / (1000 / size[0]))
                if "y" in name.lower():
                    variables[name] = str(float(variables[name]) / (6010000 / size[0]))

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
            image = file.split("/")[-1]

        if file.split(".")[-1] == "pde":
            cities = analyse(file)

        if file.endswith("data"):
            for f in glob(file+"/*"):
                if f.split(".")[-1] in img_exts:
                    image = f.split("/")[-1]

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

with open("states.pde", "w") as f:
    f.write(final + "\n\n")
    f.write(images + "\n\n")
    f.write(pimages)
