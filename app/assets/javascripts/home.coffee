# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module('blogers', [])

app.controller 'MainCtrl', ['$scope','$http','$sce',($scope, $http,$sce) ->

  $scope.callBlogs = (category_id) ->
    $http.get("/home/blogs/" + category_id + '.json').then((response) ->
      $scope.blogs= response.data
      return) 
  
  $scope.callBlog = (blog_id) ->
    $http.get("/home/blog/" + blog_id + '.json').then((response) ->
      $scope.blog= response.data.blog
      $scope.bloger= response.data.bloger
      $scope.messages = response.data.messages
      $scope.$sce = $sce     
      return)       
   
  return]
app.controller 'CategoryCtrl', ['$scope','$http',($scope, $http) ->
  $http.get('/home/categories.json').then((response) ->
    $scope.categories = response.data
    return)
  
  return]
app.controller 'BlogCtrl', ['$scope','$http',($scope, $http) ->
 
  return]

app.controller 'FormCtrl', ['$scope','$http',($scope, $http) ->
  $scope.addComment = ->
    $.post('/home/add_comment.json', 
             message_id: $scope.message.id  
             firstname: $scope.commentator.firstname
             lastname: $scope.commentator.lastname
             email: $scope.commentator.email
             comment: $scope.comment.content,
            dataType: 'json' 
            ).done (new_comment) ->
             $scope.message.comments.push new_comment
             $scope.showOverlay = false;
             $scope.$apply ->
               $scope.message.comments.update
               return
             console.log $scope.message.comments 
             return
        
    return
    $scope.form.setPristine 
    $scope.form.setUntouched    
    
  return]  

