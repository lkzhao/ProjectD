
React = require "react"
auth = require "./Auth"
ReactRouter = require "react-router"

RequireLogin =
  contextTypes:
    history: React.PropTypes.object

  componentWillMount: ->
    if !auth.loggedIn()
      @context.history.pushState null,  "/login"

module.exports = RequireLogin