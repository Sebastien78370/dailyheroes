<#assign user = principal />
<#assign contextPath = path />
<!doctype html>
<html>
<head>
    <title>Daily Heroes</title>
    <link rel="stylesheet" type="text/css" href="/webjars/bootstrap/3.3.7-1/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/webjars/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/interface.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/dashboard.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/notification.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/profile.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
</head>

<body id="page-top" ng-app="HomeApp" ng-controller="HomeCtrl">
<script type="text/javascript">
    var contextPath = window.location.origin + '${contextPath}';
    var username = '${user}';
</script>
<!-- Navigation -->
<nav id="mainNav" class="navbar navbar-default navbar-fixed-top navbar-custom">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
            </button>
            <a class="navbar-brand">
                <img src="/resources/img/logo1_small.png"/>
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="page-scroll rounded" ng-class="{'active':currentRoute.endsWith('#!/')}">
                    <a href="#!/home"><i class="fa fa-home" aria-hidden="true"></i> <span translate>Dashboard</span></a>
                </li>
                <li class="page-scroll rounded" ng-class="{'active':currentRoute.endsWith('/profile')}">
                    <a href="#!/profile"><i class="fa fa-user" aria-hidden="true"></i> <span translate>Profile</span></a>
                </li>
                <li class="page-scroll rounded" ng-class="{'active':currentRoute.endsWith('/notifications')}">
                    <a href="#!/notifications">
                        <i class="fa fa-envelope" aria-hidden="true"></i>
                        <span translate>Notifications</span>
                        <span class="badge" ng-class="{'active':notificationsCount > 0}">{{notificationsCount}}</span>
                    </a>
                </li>
                <li class="page-scroll rounded" ng-class="{'active':currentRoute.endsWith('/task')}">
                    <a href="#!/task"><i class="fa fa-plus-circle" aria-hidden="true"></i> <span translate>Add a task</span></a>
                </li>
            </ul>
            <div class="logout" ng-click="logout()">
                <i class="fa fa-sign-out"></i> ${user}
            </div>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
<div class="container app" ng-swipe-left="goToNext()" ng-swipe-right="goToPrevious()">
    <div ng-view></div>
</div>

<script type="text/ng-template" id="credits.html">
    <div>
        <a target="_blank" href="https://www.freepik.com/free-vector/colorful-pack-of-medieval-knights_1363411.htm">Logo inspired by Freepik</a>
    </div>
    <div>
        <a target="_blank" href="https://www.freepik.com/free-photos-vectors/people">Avatar resources created by Kubanek - Freepik.com</a>
    </div>
</script>

<script type="text/ng-template" id="contribute.html">
    <a target="_blank" href="https://github.com/sahbi-ktifa/dailyheroes">Contribute @ GitHub</a>
</script>
<div class="footer navbar-fixed-bottom">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                Copyright &copy; Daily Heroes 2018 - <a class="credit-line" uib-popover-template="'credits.html'" popover-title="{{'Credits' | translate}}" translate>Credits</a> - <a class="contribute-line" uib-popover-template="'contribute.html'" popover-title="{{'Contribute' | translate}}" translate>Contribute</a> - <version></version>
            </div>
        </div>
    </div>
</div>

<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
<div class="scroll-top page-scroll hidden-sm hidden-xs hidden-lg hidden-md">
    <a class="btn btn-primary" href="#page-top">
        <i class="fa fa-chevron-up"></i>
    </a>
</div>

<script type="text/javascript" src="webjars/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="webjars/angularjs/1.6.6/angular.min.js"></script>
<script type="text/javascript" src="webjars/angularjs/1.6.6/angular-resource.min.js"></script>
<script type="text/javascript" src="webjars/angularjs/1.6.6/angular-route.min.js"></script>
<script type="text/javascript" src="webjars/angular-ui-bootstrap/2.2.0/ui-bootstrap-tpls.min.js"></script>
<script type="text/javascript" src="webjars/angular-gettext/2.2.1/dist/angular-gettext.min.js"></script>
<script type="text/javascript" src="webjars/angular-touch/1.6.7/angular-touch.min.js"></script>
<script type="text/javascript" src="/resources/js/home/app.js"></script>
<script type="text/javascript" src="/resources/js/home/services.js"></script>
<script type="text/javascript" src="/resources/js/home/directives.js"></script>
<script type="text/javascript" src="/resources/js/home/controllers.js"></script>
<script type="text/javascript" src="/resources/js/home/translations.js"></script>
<script type="text/javascript" src="/resources/js/home/notification_translations.js"></script>
<script type="text/javascript" src="/resources/js/home/loot_translations.js"></script>
</body>
</html>