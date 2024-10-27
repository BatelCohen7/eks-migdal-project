import tkinter as tk

window = tk.Tk()
window.title("Hello World App")
window.geometry("300x200") 

def say_hello():
    label.config(text="Hello, World!")

label = tk.Label(window, text="", font=("Arial", 24))
label.pack(pady=20)

button = tk.Button(window, text="Say Hello", command=say_hello)
button.pack(pady=10)

window.mainloop()
