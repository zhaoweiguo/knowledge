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

func main()  {
  newTrips := trips[1:]
  result := trips[0]

  for len(newTrips) != 0  {
    log.Println("^^^", len(newTrips))
    for i,trip := range newTrips {
      if result[0] == trip[1] {
        result= append([]string{trip[0]}, result...)
        newTrips = new_trip(newTrips, i)
        log.Println("=====", result)
        break
      } else if result[len(result)-1] == trip[0] {
        result= append(result, trip[1])
        newTrips = append(newTrips[:i], newTrips[i+1:]...)
        log.Println("====>", result)
        break
      } else {
        log.Println("=====")
      }
    }
  }
  log.Println(result)
}


func new_trip(newTrips [][]string, i int) [][]string {
  if i ==0 {
    return newTrips[1:]
  } else if i == len(newTrips)-1 {
    return  newTrips[:i]
  } else {
    return append(newTrips[:i], newTrips[i+1:]...)
  }
}

