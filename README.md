# CrispSwiftUI
- Welcome to the CrispSwiftUI a Project Collection, a repository that showcases the power and versatility of the SwiftUI framework. This project folder contains a variety of smaller SwiftUI projects that demonstrate the clean and concise way that SwiftUI can be used to build amazing applications.
- The centerpiece of this project collection is the "Background Image Upload" project. This project is designed to demonstrate how to efficiently and reliably handle concurrent file uploads even when the app is in the background or events like user is receiving calls. The project is a perfect example of how to take advantage of the latest iOS technologies to create seamless and user-friendly experiences.|
- By browsing through this project collection, you'll get a chance to see how SwiftUI can be used to create intuitive and visually appealing interfaces, while still providing powerful and efficient functionality. Whether you're an experienced iOS developer looking to expand your knowledge, or a newcomer looking to get started with SwiftUI, this project collection is the perfect starting point. So why wait? Dive in and start exploring the exciting world of SwiftUI today!

- For BackgroundImageUploading project In case you want to perform live tests locally on your machine & (Quickly) followings are the Prerequisits.

	Prerequisites: 

1. Install Python 3.8 using 

	    $ sudo apt-get update
	    $ sudo apt-get install python3.8

			or

	    $ brew update 
	    $ brew install python

2. Install ‘FLASK’ in your python environment by

 	    pip3 install Flask

3. Create a Folder with the name of your choice 
	- Something Like this
	
<img width="128" alt="image" src="https://user-images.githubusercontent.com/15359399/217231125-110f0579-02ae-48fa-a1ed-8642f9a00ab1.png">


4. Create a new python File with extension .py and Add the following code to it and then save the file it will take care of the rest 

            from flask import Flask, request
            from werkzeug.utils import secure_filename
            import os
            UPLOAD_FOLDER = 'uploads'
            if not os.path.exists(UPLOAD_FOLDER):
            os.makedirs(UPLOAD_FOLDER)
            app = Flask(__name__)
            app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
            @app.route('/upload', methods=['POST'])
            def upload_file():
            file = request.files.get('file')
            name = request.form.get('name')
            age = request.form.get('age')
            print(request)
            print(age,name)
            print(file)
            if file:
            # Do something with the file, such as saving it to disk
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return 'File uploaded successfully with name: {}, age: {}'.format(name, age)
            return 'No file was uploaded'
            if __name__ == '__main__':
                app.run(debug=True)

	- by now you should have something like this 

<img width="520" alt="image" src="https://user-images.githubusercontent.com/15359399/217231339-373e2f49-974e-4b89-bd5b-e5664c454bd2.png">

5. Open terminal and Navigate (type command cd) to the directory where your app.py is stored 

	    #BLAHBLAHBLAH ~ % cd /Users/SELF/Desktop/MultipartExample

6. Type - "python3 app.py”

7. That’s it:  if steps successfully followed you will get a server URL just paste it in our Xcode Project BackgroundImageUpload

	- You should have output like this

<img width="958" alt="image" src="https://user-images.githubusercontent.com/15359399/217234250-5e228161-a9ce-4772-b3e8-866860b0cdfc.png">


8. Run the iOS app on physical device by registering your bundle ID and adding provisional profiles and quickly in simulator without any changes. Make sure to check Unit Test File in the project with which you can test the image upload, concurrency and response results. 


9. Please feel free to use any code in this repository. If it helps please give it a star and if any queries do reach us out on milindtrivedi47@gmail.com 

		Disclaimer: I do not claim any app ideas apart from "Background Image Upload":
		I have taken references from https://credo.academy/swiftui-course.html 

