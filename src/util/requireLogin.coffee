
React = require "react"
ReactRouter = require "react-router"

RequireLogin =
  contextTypes:
    history: React.PropTypes.object

  componentWillMount: ->
    if !firebase.getAuth()
      @context.history.pushState null,  "/login"

module.exports = RequireLogin