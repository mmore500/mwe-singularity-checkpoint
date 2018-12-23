#include <iostream>
#include <string>
#include <fstream>
#include <unistd.h>

int main(int argc, const char* argv[])
{

  std::string temp;

  for (int i=0; ; ++i) {

    std::ifstream file("ckpt_status");
    std::getline(file, temp);

    std::cout << "(((ckpt_status)))) " << temp
      << " /// " << "(((count))) " << i << std::endl;
    sleep(1);
  }

  return 1;
}
