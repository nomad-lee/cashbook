<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  	<meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
    <title>Ionic Elastichat</title>
  	<link rel="stylesheet" href="assets/css/chatStyle.css">
    <link href="//code.ionicframework.com/1.0.0-beta.14/css/ionic.min.css" rel="stylesheet">
    <script src="//code.ionicframework.com/1.0.0-beta.14/js/ionic.bundle.min.js"></script> 
    <!-- moment -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
    <!-- angular moment -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-moment/0.8.2/angular-moment.min.js"></script>
  </head>
  <body ng-app="elastichat">
    <ion-nav-bar class="bar-positive" no-tap-scroll="false">
      <ion-nav-back-button class="button-icon ion-arrow-left-c">
      </ion-nav-back-button>
    </ion-nav-bar>
    <!-- 
      The views will be rendered in the <ion-nav-view> directive below
      Templates are in the /templates folder (but you could also
      have templates inline in this html file if you'd like).
      -->
    <ion-nav-view>
    
    </ion-nav-view>
    <script id="templates/UserMessages.html" type="text/ng-template">
      <ion-view id="userMessagesView"
          cache-view="false" 
          view-title="<i class='icon ion-chatbubble user-messages-top-icon'></i> <div class='msg-header-username'>{{toUser.username}}</div>">
        
        <div class="loader-center" ng-if="!doneLoading">
            <div class="loader">
              <i class="icon ion-loading-c"></i>
            </div>
        </div>
      
          <ion-content has-bouncing="true" class="has-header has-footer" 
              delegate-handle="userMessageScroll">
            
              <div ng-repeat="message in messages" class="message-wrapper"
                  on-hold="onMessageHold($event, $index, message)">
      
                  <div ng-if="user._id !== message.userId">
                      
                    <img ng-click="viewProfile(message)" class="profile-pic left" 
                          ng-src="{{toUser.pic}}" onerror="onProfilePicError(this)" />
      
                      <div class="chat-bubble left">
      
                          <div class="message" ng-bind-html="message.text | nl2br" autolinker>
                          </div>
      
                          <div class="message-detail">
                              <span ng-click="viewProfile(message)" 
                                  class="bold">{{toUser.username}}</span>,
                              <span am-time-ago="message.date"></span>
                          </div>
      
                      </div>
                  </div>
      
                  <div ng-if="user._id === message.userId">
                    
                       <img ng-click="viewProfile(message)" class="profile-pic right" 
                          ng-src="{{user.pic}}" onerror="onProfilePicError(this)" />
                    
                      <div class="chat-bubble right">
      
                          <div class="message" ng-bind-html="message.text | nl2br" autolinker>
                          </div>
      
                          <div class="message-detail">
                              <span ng-click="viewProfile(message)" 
                                  class="bold">{{user.username}}</span>, 
                              <span am-time-ago="message.date"></span>
                          </div>
      
                      </div>
                    
                  </div>
      
                  <div class="cf"></div>
      
              </div>
          </ion-content>
      
          <form name="sendMessageForm" ng-submit="sendMessage(sendMessageForm)" novalidate>
              <ion-footer-bar class="bar-stable item-input-inset message-footer" keyboard-attach>
                  <label class="item-input-wrapper">
                      <textarea ng-model="input.message" value="" placeholder="Send {{toUser.username}} a message..." required minlength="1" maxlength="1500" msd-elastic></textarea>
                  </label>
                  <div class="footer-btn-wrap">
                    <button class="button button-icon icon ion-android-send footer-btn" type="submit"
                        ng-disabled="!input.message || input.message === ''">
                    </button>
                  </div>
              </ion-footer-bar>
          </form>
          
      </ion-view>
    </script>
  <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
  <script  src="assets/js/chatScript.js"></script>
  </body>
</html>
