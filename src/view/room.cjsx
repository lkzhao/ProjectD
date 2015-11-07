
React = require "react"
ReactCSSTransitionGroup = require "react-addons-transition-group"

Router = require "react-router"

RequireAuth = require "../util/requireLogin"
RequireProfile = require "../util/requireProfile"
AddFriend = require "./addFriend"


mui = require "material-ui"
Colors = require 'material-ui/src/styles/colors'
TextField = mui.TextField
Paper = mui.Paper
Tabs = mui.Tabs
Tab = mui.Tab
IconButton = mui.IconButton
FontIcon = mui.FontIcon
RaisedButton = mui.RaisedButton
FlatButton = mui.FlatButton
FloatingActionButton = mui.FloatingActionButton


Header = require "./header"
SideBar = require "./sideBar"

module.exports = React.createClass
  render: ->
    <div>
      <Header />
    </div>