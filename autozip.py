import zipfile
filenames = ["assets", "pack.mcmeta"]
with zipfile.ZipFile("assets.zip", mode="w") as archive:
   for filename in filenames:
       archive.write(filename)
print("Done!")