React = require "react"
LinkedStateMixin = require 'react-addons-linked-state-mixin'
Router = require "react-router"
History = Router.History

mui = require "material-ui"
Colors = require 'material-ui/src/styles/colors'
TextField = mui.TextField
Paper = mui.Paper
FontIcon = mui.FontIcon
FlatButton = mui.FlatButton
Tabs = mui.Tabs
Tab = mui.Tab

module.exports = React.createClass  
  mixins:[History, LinkedStateMixin]

  getInitialState: ->
    name: ""
    email: ""
    username: ""
    password: ""

    usernameError: null
    passwordError: null
    emailError: null

    globalError: null
    loading: false

  handleUsernameChange: (e) ->
    @setState 
      username:e.target.value
      usernameError: null

  handlePasswordChange: (e) ->
    @setState 
      password:e.target.value
      passwordError: null

  handleEmailChange: (e) ->
    @setState 
      email:e.target.value
      emailError: null

  componentWillMount: ->
    if firebase.getAuth()
      @history.pushState null, "/"

  handleLogin: ->
    console.log "login"
    if @state.loading
      return
    if !@state.username
      @setState usernameError:"Username cannot be blank"
    if !@state.password
      @setState passwordError:"Password cannot be blank"
    if !@state.password || !@state.username
      return
    @login()

  login: ->
    @setState loading: true
    firebase.authWithPassword(
      email: @state.username,
      password: @state.password
    , (error, authData) =>
      if authData
        @history.pushState null,   "/"
      else
        @setState 
          globalError: error.message
          loading: false
    )        

  signupFailed: (error) ->

    @setState 
      globalError: error.message
      loading: false
    firebase.removeUser
      email: @state.email
      password: @state.password
    , (error) ->
      if error
        alert "Fatal error, Please contact customer support"

  handleSignup: ->
    if @state.loading
      return
    @setState loading: true
    firebase.createUser({
      email: @state.email,
      password: @state.password
    }, (error, userData) =>
      if userData
        firebase.authWithPassword(
          email: @state.email,
          password: @state.password
        , (error, authData) =>
          if authData
            firebase.child("user/#{authData.uid}").set
              name: @state.name
              provider: "password"
              image: ""
            , (error) =>
              if error
                @signupFailed(error)
              else
                @history.pushState null,   "/"
          else
            @signupFailed(error)
        )     
      else
        @setState 
          globalError: error.message
          loading: false
    )

  goToRoute: (tab) ->
    @setState globalError:null
    @history.pushState null,   tab.props.route

  render: ->
    <Paper className="center" zDepth={2}>
      <Tabs initialSelectedIndex={if @props.location.pathname=="/login" then 0 else 1}> 
        <Tab label="Login" onActive={@goToRoute} route="login">
          <div className="inner">
            <div className="error">{@state.globalError}</div>
            <TextField
              key="username"
              style={width:"100%"}
              hintText="johnappleseed"
              floatingLabelText="Username" value={@state.username} onChange={@handleUsernameChange} errorText={@state.usernameError}
              disabled={@state.loading} />
            <TextField
              key="password"
              style={width:"100%"}
              type="password"
              floatingLabelText="Password" value={@state.password} onChange={@handlePasswordChange} errorText={@state.passwordError}
              disabled={@state.loading} />
            <FlatButton style={width:"100%"} onClick={@handleLogin} secondary={true}>
              {if @state.loading then <FontIcon className="fa fa-spinner fa-pulse"/> else <span>Login</span>}
            </FlatButton>
          </div>
        </Tab>
        <Tab label="Signup" onActive={@goToRoute} route="signup">
          <div className="inner">
            <div className="error">{@state.globalError}</div>
            <TextField
              key="name"
              style={width:"100%"}
              hintText="John Appleseed"
              floatingLabelText="Name" valueLink={@linkState('name')}
              disabled={@state.loading} />
            <TextField
              key="username"
              style={width:"100%"}
              hintText="johnappleseed"
              floatingLabelText="Username" value={@state.username} onChange={@handleUsernameChange} errorText={@state.usernameError}
              disabled={@state.loading} />
            <TextField
              key="email"
              style={width:"100%"}
              hintText="example@instantchat.com"
              floatingLabelText="Email" value={@state.email} onChange={@handleEmailChange} errorText={@state.emailError}
              disabled={@state.loading} />
            <TextField
              key="password"
              style={width:"100%"}
              type="password"
              floatingLabelText="Password" value={@state.password} onChange={@handlePasswordChange} errorText={@state.passwordError}
              disabled={@state.loading} />
            <FlatButton style={width:"100%"} disabled={@state.loading} onClick={@handleSignup} secondary={true}>
              {if @state.loading then <FontIcon className="fa fa-spinner fa-pulse"/> else <span>Sign up</span>}
            </FlatButton>
          </div>
        </Tab> 
      </Tabs>
    </Paper>