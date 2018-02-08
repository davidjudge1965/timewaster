while :
do
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=2" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
	curl http://twui:8080/TimeWasterUI/TimeWaster.html
	curl -d "secondsToWaste=32" -X POST http://twui:8080/TimeWasterUI/doTimeWasting.jsp
	sleep 1
done

