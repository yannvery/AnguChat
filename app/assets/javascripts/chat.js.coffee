window.app = angular.module("chat", ["ngResource"])

#Resource
app.factory "Message", ["$resource", ($resource) ->
	$resource('/api/v1/messages/:id', {id: "@id"}, { update: { method:'UPDATE'}})
]

app.factory "QMessage", ["$resource", ($resource) ->
	$resource('/api/v1/messages/pool/', {last_id: "@last_id"}, { save: { method:'POST', isArray: true}})
]

#Controller Messages
app.controller "ChatCtrl", ["$scope", "Message", "QMessage", "$http", "$timeout", ($scope,Message,QMessage,$http,$timeout) ->
	$scope.messages = Message.query({}, success = -> 
		$scope.last_message = $scope.messages[$scope.messages.length-1].id
		$scope.$watch "messages", ->
		  scrollChatBox()
	)
	
	timer = setInterval(->
		$scope.qmessages = QMessage.save({last_id:$scope.last_message}, success = -> 
			i = 0
			while i<=$scope.qmessages.length-1
				$scope.messages.push($scope.qmessages[i])
				i++
			if $scope.qmessages[$scope.qmessages.length-1]
				$scope.last_message = $scope.qmessages[$scope.qmessages.length-1].id
		)
		$scope.$apply()
		scrollChatBox()
	, 5000)
	
	$scope.addMessage = ->
		concatMessage = $scope.nickname.concat(" : ").concat($scope.newMessage.content)
		$scope.newMessage.content = concatMessage
		message = Message.save($scope.newMessage, success = -> 
			$scope.messages.push(message)
			$scope.last_message = $scope.messages[$scope.messages.length-1].id
			$scope.newMessage = {}
			scrollChatBox()
		)
	
	#Scroll chatBox
	scrollChatBox = ->
		$("#chatBox").animate
			scrollTop: $("#chatBox")[0].scrollHeight
		, 1000
	
]
