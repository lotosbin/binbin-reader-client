var app, config, fetch;

config = {
  host: 'http://localhost:5001',
  test: ''
};

fetch = function(callback) {
  var spide, url;
  spide = require('rssspider');
  url = 'http://www.bigertech.com/rss';
  return spide.fetchRss(url).then(function(data) {
    console.log(data);
    if (callback) {
      return callback(data);
    }
  });
};

app = angular.module('myapp', []);

app.controller('feedCtrl', function($scope, $http, $sce) {
  fetch(function(data) {
    var k, results, v;
    results = [];
    for (k in data) {
      v = data[k];
      results.push($http.post(config.host + '/articles', {
        thirdId: v.link,
        title: v.title
      }));
    }
    return results;
  });
  $scope.articles = [];
  $http.get(config.host + '/articles').success(function(data) {
    return $scope.articles = data;
  });
  $scope.feeds = [
    {
      url: 'slkdfjslkd'
    }, {
      url: 'lsdflskdjf'
    }
  ];
  $scope.trustAsResourceUrl = function(url) {
    return $sce.trustAsResourceUrl(url);
  };
  $scope.article = {};
  $scope.article_select = function(article) {
    return $scope.article = article;
  };
  $scope.load = function() {
    $http.get(config.host + '/feeds').success(function(data) {
      $scope.feeds = data;
    });
  };
  $scope.url = 'http://www.cnbeta.cn';
  $scope.$watch('url', function(newValue, oldValue) {
    return $http.get('');
  });
  $scope.add = function($event) {
    if ($event) {
      $event.preventDefault();
    }
    $http.post(config.host + '/feeds', {
      url: $scope.url
    }).success(function() {
      alert('add success');
      $scope.load();
    });
    return false;
  };
  $scope.detail = {};
  $scope.select = function(f) {
    var u;
    $scope.detail = f;
    u = config.host + '/feeds/' + f.id + '/detail/';
    $http.post(u).success(function(data) {
      $http.get(u).success(function(data) {
        $scope.detailfeed = data;
      });
    });
  };
  $scope.view = function(f) {};
});
