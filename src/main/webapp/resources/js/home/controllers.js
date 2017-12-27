(function(angular) {
    var HomeCtrl = function($scope) {
        $scope.dashboard = {};
        $scope.$on('$locationChangeStart', function($event, next) {
            $scope.currentRoute = next;
        });

        $scope.logout = function () {
            window.location.href = contextPath + '/logout';
        };
    };
    HomeCtrl.$inject = ['$scope'];

    var DashboardCtrl = function($scope, Dashboard, Task, $uibModal) {
        $scope.loading = true;
        $scope.tasks = [];
        var refreshTasks = function () {
            Task.retrieveTasks($scope.dashboard.id).then(function (response) {
                $scope.tasks = response.data;
                $scope.loading = false;
            });
        };

        Dashboard.retrieveDashboardForUser(username).then(function (response) {
            $scope.dashboard = response.data;
            refreshTasks();
        });

        $scope.validTask = function (task) {
            if (confirm('Are you sure that you performed this task?')) {
                Task.validTask(task.id).then(function () {
                    refreshTasks();
                });
            }
        };

        $scope.deleteTask = function (task) {
            if (confirm('Are you sure that you want to delete this task?')) {
                Task.deleteTask(task.id).then(function () {
                    refreshTasks();
                });
            }
        };

        $scope.editTask = function (task) {
            var modalInstance = $uibModal.open({
                template: '<div>' +
                '   <div class="modal-header">' +
                '       <h3 class="modal-title">Edit task</h3>' +
                '   </div>' +
                '   <div class="modal-body">' +
                '       <task-form task="$ctrl.task"></task-form>' +
                '   </div>' +
                '   <div class="modal-footer">' +
                '       <button class="btn btn-primary" type="button" ng-click="$ctrl.ok()">OK</button>\n' +
                '       <button class="btn btn-warning" type="button" ng-click="$ctrl.cancel()">Cancel</button>\n' +
                '   </div>' +
                '</div>',
                controller: EditTaskCtrl,
                controllerAs: '$ctrl',
                resolve: {
                    task: function () {
                        return task;
                    }
                }
            });

            modalInstance.result.then(function (task) {
                 Task.updateTask(task).then(function () {
                     refreshTasks();
                 });
            });
        };
    };
    DashboardCtrl.$inject = ['$scope', 'Dashboard', 'Task', '$uibModal'];

    var EditTaskCtrl = function($scope, $uibModalInstance, task) {
        var $ctrl = this;
        $ctrl.task = task;

        $ctrl.ok = function () {
            $uibModalInstance.close($ctrl.task);
        };

        $ctrl.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };
    };
    EditTaskCtrl.$inject = ['$scope', '$uibModalInstance', 'task'];

    var ProfileCtrl = function($scope) {

    };
    ProfileCtrl.$inject = ['$scope'];

    var NotificationsCtrl = function($scope) {

    };
    NotificationsCtrl.$inject = ['$scope'];

    var CreateTaskCtrl = function($scope, Task, Dashboard) {
        $scope.task = {};
        $scope.success = false;
        var refId = null;

        Dashboard.retrieveDashboardForUser(username).then(function (response) {
            refId = response.data.id;
        });

        $scope.createTask = function () {
            $scope.success = false;
            $scope.task.status = 'todo';
            $scope.task.dashboardId = refId;
            Task.createTask($scope.task).then(function () {
                $scope.task = {};
                $scope.success = true;
            });
        };
    };
    CreateTaskCtrl.$inject = ['$scope', 'Task', 'Dashboard'];

    angular.module("HomeApp.controllers").controller("HomeCtrl", HomeCtrl);
    angular.module("HomeApp.controllers").controller("DashboardCtrl", DashboardCtrl);
    angular.module("HomeApp.controllers").controller("ProfileCtrl", ProfileCtrl);
    angular.module("HomeApp.controllers").controller("NotificationsCtrl", NotificationsCtrl);
    angular.module("HomeApp.controllers").controller("CreateTaskCtrl", CreateTaskCtrl);
}(angular));