var app, config;

config = {
  host: 'http://localhost:21712',
  test: ''
};

app = angular.module('myapp', []);

app.controller('feedCtrl', function($scope, $http) {
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
