
React = require "react"
Router = require "react-router"
auth = require "../util/Auth"
Link = Router.Link

Router = require "react-router"
RequireAuth = require "../util/requireLogin"

Header = require "./header"
SideBar = require "./sideBar"

mui = require "material-ui"
Colors = require 'material-ui/src/styles/colors'
TextField = mui.TextField
Paper = mui.Paper
FontIcon = mui.FontIcon
RaisedButton = mui.RaisedButton

module.exports = React.createClass
  mixins:[RequireAuth]

  componentDidMount: ->
    console.log "Dashboard mounted, starting map"
    L.mapbox.accessToken = 'pk.eyJ1IjoibHVrZXpoYW8zMjEiLCJhIjoiY2lnbWR2MzVpMDIxZnVubHpoc3F6ZzZ6NCJ9.344jdCjw6a26O4TLgaEWLA';
    L.mapbox.map('map-one', 'mapbox.streets').setView([38.8929,-77.0252], 14);
  
  render: ->
    <div>
      <Header />
      <SideBar {...@props}/>
      <div id="map-one" className="map"> </div>
    </div>