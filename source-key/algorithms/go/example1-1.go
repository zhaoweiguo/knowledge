package main

import "log"

var trips = [][]string{
  []string{"重庆", "新疆"},
  []string{"广州", "南京"},
  []string{"上海", "广州"},
  []string{"西藏", "重庆"},
  []string{"北京", "上海"},
  []string{"南京", "西藏"},
}

func main() {
  //本题时间为30分钟
  //trips是小明出差的行程， 请找出小明这次行程，并注释时间复杂度与空间复杂度
  //结果 [北京"，"上海", "广州", "南京", "西藏", "重庆"，"新疆"]
  var result []string
  i := 1
  for _, trip := range trips {
    log.Println("-", trip)
    if len(result) == 0 {
      result = trip
      continue
    }
    //log.Println(newTrips)
    for _, trip := range trips {
      //log.Println("$", trip)
      if result[0] == trip[1] {
        result= append(trip, result[1:]...)
        log.Println("=====", result)
        break
      } else if result[len(result)-1] == trip[0] {
        result= append(result, trip[1])
        log.Println("====>", result)
        break
      } else {
        log.Println("=====")
      }
    }
    i++
  }
  log.Println(result)
}



