################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../robot_razi/run.cpp 

OBJS += \
./robot_razi/run.o 

CPP_DEPS += \
./robot_razi/run.d 


# Each subdirectory must supply rules for building sources it contributes
robot_razi/%.o: ../robot_razi/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross G++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


