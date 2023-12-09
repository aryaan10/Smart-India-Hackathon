# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

from apps.home import blueprint
from flask import Flask, render_template, request, Response, send_file
from flask_login import login_required, current_user
from jinja2 import TemplateNotFound
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.backends.backend_agg import FigureCanvasAgg
from matplotlib.figure import Figure
import io
import base64
import os
import joblib
import matplotlib

matplotlib.use("Agg")  # Set the backend to Agg


@blueprint.route("/index")
@login_required
def index():
    return render_template("home/index.html", segment="index", user_id=current_user.id)


@blueprint.route("/<template>")
@login_required
def route_template(template):
    try:
        if not template.endswith(".html"):
            template += ".html"

        # Detect the current page
        segment = get_segment(request)

        # Serve the file (if exists) from app/templates/home/FILE.html
        return render_template("home/" + template, segment=segment)

    except TemplateNotFound:
        return render_template("home/page-404.html"), 404

    except:
        return render_template("home/page-500.html"), 500


# Helper - Extract current page name from request
def get_segment(request):
    try:
        segment = request.path.split("/")[-1]

        if segment == "":
            segment = "index"

        return segment

    except:
        return None


@blueprint.route("/temp")
@blueprint.route("/", methods=["POST"])
# def predict():
#     datasetfile= request.files['datasetfile']
#     dataset_path = "./dataset/" + datasetfile.filename
#     datasetfile.save(dataset_path)
#     trace = pd.read_csv(dataset_path)
#     fig = Figure()
#     axis = fig.add_subplot(1, 1, 1)

#     x_values = np.arange(0, 5000)
#     for column in trace.columns:
#         y_values = trace[column]
#         axis.plot(x_values, y_values, label=column)
#     # axis.plot(x_values, y_values)

#     axis.set_xlabel('Sample')
#     axis.set_ylabel('Amplitude')
#     axis.set_title('Trojanised - Power Consumption Trace')

#     axis.legend()
#     # Save the plot as an image
#     # plot_path = os.path.join("static", "waveform.png")
#     # plt.savefig(plot_path, format='png')

#     output = io.BytesIO()
#     FigureCanvasAgg(fig).print_png(output)
#     return Response(output.getvalue(), mimetype="image/png")

# return render_template('home/dashboard.html',plot_path=plot_path)

# @blueprint.route('/dashboard')
# def dashboard():
#     return render_template('dashboard.html')


# def predict():
#     # Read the traces file (assuming it's a CSV file)
#     datasetfile= request.files['datasetfile']
#     dataset_path = "./dataset/" + datasetfile.filename
#     datasetfile.save(dataset_path)
#     trace = pd.read_csv(dataset_path)

#     # plt.plot(trace)
#     x_values = np.arange(0, 5000)
#     for column in trace.columns:
#         y_values = trace[column]

#     plt.xlabel('Sample')
#     plt.ylabel('Amplitude')
#     plt.title('Trojanised - Power Consumption Trace')

#     plt.show()

#     # buffer = io.BytesIO()
#     # plt.savefig(buffer, format="png")
#     # buffer.seek(0)
#     # return send_file(buffer, mimetype="image/png")
#     # # Save the plot as an image
#     plot_path = "./static/plot.png"
#     plt.savefig(plot_path)

#     return render_template('home/dashboard.html', plot_path=plot_path)


def predict():
    # # Read the traces file (assuming it's a CSV file)
    # datasetfile= request.files['datasetfile']
    # dataset_path = "./dataset/" + datasetfile.filename
    # datasetfile.save(dataset_path)

    # # Load the pre-trained model
    # model = joblib.load('C:/Users/Nikhita/OneDrive/Desktop/FlaskIntro/Template2/trained_model.joblib')

    # # Read the CSV file using Pandas
    # data = pd.read_csv(dataset_path)
    # print(data)
    # pred = model.predict(data)[0]

    # # Convert the prediction to True or False
    # result = True if pred == 0 else False

    # Read the traces file (assuming it's a CSV file)
    datasetfile = request.files["datasetfile"]
    dataset_path = "./dataset/" + datasetfile.filename
    datasetfile.save(dataset_path)

    # Load the pre-trained model
    model = joblib.load(
        "C:/Users/Aryaan Pandhare/OneDrive/Desktop/New folder (2)/flask-volt-dashboard/trained_model.joblib"
    )

    # Read the CSV file using Pandas without specifying column names
    data = pd.read_csv(dataset_path, header=None)
    # Extract the values from the DataFrame column as a list
    # x_values = data[0].tolist()

    # print(x_values)
    # Make predictions
    pred = model.predict(data)[0]

    # Convert the predictions to True or False based on your logic
    result = True if pred == 0 else False
    # image_path = generate_plot(x_values)
    # plt.plot(data)
    # plt.xlabel("Sample")
    # plt.ylabel("Amplitutde")

    # plt.savefig("apps/static/my_plot.png")
    # Plot each column separately
    # Plot the data
    # /plt.figure()  # Create a new figure for each request
    plt.plot(data.columns, data.iloc[0, :])
    img_buf = io.BytesIO()
    plt.savefig(img_buf, format="png")
    img_buf.seek(0)

    # Convert the BytesIO object to base64 for embedding in HTML
    img_data = base64.b64encode(img_buf.read()).decode("utf-8")
    plt.savefig("apps/static/my_plot.png")

    return render_template("home/dashboard.html", prediction=result, img_data=img_data)
