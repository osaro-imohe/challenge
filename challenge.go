package main

import "fmt"

type Person struct {
  age  int
}
// return true if there is a person who is exactly twice as old as any other person in the list
func personIsTwiceAsOld (persons []Person) bool {
	mappings := make(map[int]int)
	for i := 0; i < len(persons); i ++ {
		mappings[persons[i].age * 2] = persons[i].age
	}

	for i := 0; i < len(persons); i ++ {
		if value, ok := mappings[persons[i].age]; ok {
			fmt.Println(value)
			return true
		}
	}
	return false
}

func main() {
	var people []Person
	for i := 0; i < 100; i++ {
		people = append(people, Person{age: i})
	}
	fmt.Println(personIsTwiceAsOld(people))
}