Auth = require "../util/Auth"
React = require "react"
ReactDom = require 'react-dom'
ReactRouter = require "react-router"
FireBase = require "firebase"
ReactFire = require "reactfire"

Link = ReactRouter.Link
Route = ReactRouter.Route
IndexRoute = ReactRouter.IndexRoute
Redirect = ReactRouter.Redirect
Router = ReactRouter.Router

Room = require "./room"
Login = require "./login"
Dashboard = require "./dashboard"
SignupSuccess = require "./signupSuccess"

ThemeManager = require("material-ui/lib/styles/theme-manager")
injectTapEventPlugin = require "react-tap-event-plugin"

Colors = require("material-ui/src/styles/colors")
Theme = require "./theme"
injectTapEventPlugin()

App = React.createClass
  childContextTypes:
    muiTheme: React.PropTypes.object

  getChildContext: () ->
    muiTheme: ThemeManager.getMuiTheme(Theme)

  render: ->
    <div className="main">
      {@props.children}
    </div>


NotFound = React.createClass
  render: ->
    <h1> 404 - Not Found </h1>

routes =
  <Router>
    <Route name="app" path="/" component={App}>
      <Route name="chat" path="chat/:roomId" component={Room}/>
      <IndexRoute component={Dashboard}/>
      <Route name="login" path="login" component={Login}/>
      <Route name="signup" path="signup" component={Login}/>
      <Route name="signupSuccess" path="signupSuccess" component={SignupSuccess} />
      <Route path="*" component={NotFound}/>
    </Route>
  </Router>

ReactDom.render routes, $("#main").get(0)
