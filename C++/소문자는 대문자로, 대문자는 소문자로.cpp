/*
소문자->대문자
대문자->소문자
*/
#include <iostream>
#include <string>
#include <vector>
using namespace std;

int main()
{
	int lowerA = 'a', sub = 'a' - 'A';
	string str;
	getline(cin, str);

	for (int i = 0; i < str.length(); i++)
	{
		if (isalpha(str[i]))//문자라면
		{
			if (str[i] >= lowerA) str[i] -= sub;//소문자
			else str[i] += sub;//대문자
		}
	}
	cout << str << endl;
	return 0;
}