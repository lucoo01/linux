```
apt-get install gnustep
apt-get install gnustep-devel
apt-get install gobjc
```

vim ~/.cshrc
```
#set GNUstep
GNUSTEP_ROOT=/usr/share/GNUstep
export GNUSTEP_ROOT
source /usr/share/GNUstep/Makefiles/GNUstep.sh
```

vim hello.m
```
#import <Foundation/Foundation.h>
 
int main (int argc, const char * argv[])
{
        NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
        NSLog (@"hello world");
        [pool drain];
        return 0;
}
```

```
source ~/.cshrc
gcc `gnustep-config --objc-flags` -o hello hello.m -L /GNUstep/System/Library/Libraries -lobjc -lgnustep-base
```

./hello