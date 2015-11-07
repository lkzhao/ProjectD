module.exports = 
  entry: "./src/view/main"
  output:
    path: "public/javascripts/"
    filename: "main.js"
  watch: true
  resolve:
    extensions: ["", ".js", ".coffee", ".cjsx"]
  module:
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loader: 'coffee' }
    ]