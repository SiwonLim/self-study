/*
재귀함수를 이용해 list배열의 최대값 찾기
*/
#include <iostream>
#include <list>
#include <time.h>
using namespace std;

int find_max(list<int> L)
{
	int v1, v2_return;
	list<int> v2;
	//1.
	if (L.size() <= 1) return L.front();
	
	//2.
	v1 = L.front();
	L.pop_front();
	v2 = L;

	//3.
	v2_return = find_max(v2);
	return (v1 > v2_return) ? v1 : v2_return;
}

int main()
{
	srand(time(NULL));
	list<int> L;
	for (int i = 0; i < 10; i++)
		L.push_back(rand() % 100 + 1);
	for (list<int>::iterator it=L.begin();it!=L.end();it++)
		cout << *it << " ";
	cout << endl;
	cout << "max : " << find_max(L) << endl;
	return 0;
}