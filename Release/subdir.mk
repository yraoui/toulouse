################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Fusion1.cpp \
../GeometricUtils.cpp \
../Utilities.cpp \
../Vision.cpp \
../ax11_style.cpp \
../fusion2.cpp \
../isInSector.cpp \
../monocularv.cpp \
../pcd_write.cpp \
../robot.cpp \
../run.cpp \
../sterio_interpretation.cpp \
../test.cpp \
../test0.cpp \
../test1.cpp \
../test2.cpp 

OBJS += \
./Fusion1.o \
./GeometricUtils.o \
./Utilities.o \
./Vision.o \
./ax11_style.o \
./fusion2.o \
./isInSector.o \
./monocularv.o \
./pcd_write.o \
./robot.o \
./run.o \
./sterio_interpretation.o \
./test.o \
./test0.o \
./test1.o \
./test2.o 

CPP_DEPS += \
./Fusion1.d \
./GeometricUtils.d \
./Utilities.d \
./Vision.d \
./ax11_style.d \
./fusion2.d \
./isInSector.d \
./monocularv.d \
./pcd_write.d \
./robot.d \
./run.d \
./sterio_interpretation.d \
./test.d \
./test0.d \
./test1.d \
./test2.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


