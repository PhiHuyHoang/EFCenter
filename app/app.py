from flask import Flask
import os
app = Flask(__name__)

@app.route("/")
def hello():
    return "The message is: {0}".format(os.environ['MESSAGE'])

if __name__ == "__main__":
    app.run()
