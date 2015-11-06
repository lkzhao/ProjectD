
mui = require "material-ui"
AppBar =  mui.AppBar
RaisedButton = mui.RaisedButton
FlatButton = mui.FlatButton
Paper = mui.Paper
Dialog = mui.Dialog
Menu = mui.Menu


Router = require "react-router"
History = Router.History

auth = require "../util/Auth"
RequireProfile = require "../util/requireProfile"

React = require "react"

module.exports = React.createClass
  mixins:[History, RequireProfile]

  handleUpload: ->
    auth.uploadImage $('#imageUpload')[0].files[0], (success) ->
      if !success
        return
        # TODO show error

  handleImageClick: ->
    $("#imageUpload").click()

  handleProfileOpen: ->
    @refs.dialog.show()

  handleLogout: ->
    @refs.dialog.dismiss()
    auth.logout()
    @history.pushState null,   "/login"

  handleCancel: ->
    @refs.dialog.dismiss()

  render: ->
    name = @state.profile.name || @state.profile.username
    standardActions = [
      { text: 'Cancel', onClick: @handleCancel, ref: 'cancel' }
      { text: 'Logout', onClick: @handleLogout, ref: 'logout' }
    ]
    filterMenuItems = [
       { payload: '1', text: 'Name', data: @state.profile.name}
       { payload: '2', text: 'InstantChat Username', data: @state.profile.username}
       { payload: '3', text: 'Gender', data: 'Male' }
       { payload: '4', text: 'Allow to Receive Messages From Unknown People', toggle: true, disabled: true}
    ]

    <header className="header">
      <div className="profile" onClick={@handleProfileOpen}>
        <img src={@state.profile.image}/>
      </div>
      <input type="file" id="imageUpload"  style={display:"none"} onChange={@handleUpload}/>
      <Dialog
        ref="dialog"
        title={name}
        contentClassName="profileDialog"
        actions={standardActions}
        actionFocus="logout"
        modal={true}>
        <div className="dialogHeader">
        </div>
        <div className="profileImage">
          <img src={@state.profile.image} />
          <div id="editImageButton">
            <FlatButton style={width:"100%"} label="Edit" primary={true} onClick={@handleImageClick}/>
          </div>
        </div>
        <div className="name">{name}</div>
        <div className="dialogContent">
          <Menu menuItems={filterMenuItems} autoWidth={false}/>
        </div>
        
      </Dialog>
    </header>