config =
  # host : 'http://readerapi.binbinsoft.com'
  host : 'http://localhost:5001'
  test : ''
fetch = (callback)->
  spide = require 'rssspider'
  url = 'http://www.bigertech.com/rss'
  spide.fetchRss url
    .then (data)->
      console.log data
      callback(data) if callback

app = angular.module('myapp', [])
app.controller 'feedCtrl', ($scope, $http,$sce) ->
  fetch (data)->
    for k,v of data
      $http.post config.host+'/articles',{thirdId:v.link,title:v.title}
  $scope.articles = [];
  $http.get(config.host+'/articles').success (data) ->
    $scope.articles = data
  $scope.feeds = [
    { url: 'slkdfjslkd' }
    { url: 'lsdflskdjf' }
  ]
  $scope.trustAsResourceUrl = (url)->
    $sce.trustAsResourceUrl(url)
  $scope.article = {}
  $scope.article_select = (article) ->
    $scope.article = article;
  $scope.load = ->
    $http.get(config.host + '/feeds').success (data) ->
      $scope.feeds = data
      return
    return


  # $scope.load()
  $scope.url = 'http://www.cnbeta.cn'
  $scope.$watch 'url',(newValue,oldValue) ->
    $http.get('')
  $scope.add = ($event) ->
    if $event
      $event.preventDefault()
    $http.post(config.host + '/feeds', url: $scope.url).success ->
      alert 'add success'
      $scope.load()
      return
    false

  $scope.detail = {}

  $scope.select = (f) ->
    $scope.detail = f
    u = config.host + '/feeds/' + f.id + '/detail/'
    $http.post(u).success (data) ->
      $http.get(u).success (data) ->
        $scope.detailfeed = data
        return
      return
    return
  $scope.view = (f) ->
    return

  return
