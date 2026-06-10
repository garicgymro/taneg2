import os


def compare_files(file_list):
	actual_img_files = os.listdir("img")
	for f in file_list:
		if f[0:3] == "img":
			split_filename = os.path.split(f)
			filename = split_filename[1]
		else:
			filename = f 

		if filename not in actual_img_files:
			print(f, "is not there!")




