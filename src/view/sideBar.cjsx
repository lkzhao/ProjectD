

React = require "react"
Router = require "react-router"
Link = Router.Link

mui = require "material-ui"
TextField = mui.TextField
FlatButton = mui.FlatButton
FontIcon = mui.FontIcon

RequireProfile = require "../util/requireProfile"

module.exports = React.createClass
  mixins:[RequireProfile]
  getInitialState: ->
    searchQuery: ""

  componentDidMount: ->
    return

  handleChange: (e)->
    @setState searchQuery:e.target.value.toUpperCase()

  render: ->
    <div className="sideBar">
      <header>
        <TextField key="searchContact" style={width:"100%"} className="search" floatingLabelText="Search" hintText="CS350" onChange={@handleChange}  value={@state.searchQuery} />
      </header>
      <div key="contacts">
      </div>
      <div key="people">
      </div>
    </div>