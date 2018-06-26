#pragma once
#include<stdlib.h>
#include<stdio.h>
#include<iostream>
#include<string>
#include<cstring>
#include<unistd.h>
#include<vector>



class MemoryEater
{
	public:
	~MemoryEater();
	MemoryEater(std::string);
	void free_memory();

	private:
		float total_memory;
		float allocated_memory;
		int** arr;
		void allocate_memory();
		float parse(std::string);
		std::vector<int> allocated;
		bool freed;

};
