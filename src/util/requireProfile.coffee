
React = require "react"


RequireProfile =
  getInitialState: ->
    profile: {}

  authChanged: (authData) ->
    if authData
      @ref = firebase.child "user/#{authData.uid}"
      @ref.on "value", (user) =>
        @setState profile: user
    else if @ref
      @ref.off "value"

  componentDidMount: ->
    @authChanged firebase.getAuth()
    firebase.onAuth @authChanged

  componentWillUnmount: ->
    @authChanged()
    firebase.offAuth @authChanged


module.exports = RequireProfile