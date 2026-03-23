#include "tripcomputerdatamodel.h"
#include "sm_tripcomputer.hpp"
#include <QTime>

TripComputerDataModel::TripComputerDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent}
{
}

void TripComputerDataModel::updateData()
{
    DATA_PROERTY_CHECK(tripcomputer_Odo)
    DATA_PROERTY_CHECK(tripcomputer_AC_EnvironmentalTemp)
    DATA_PROERTY_CHECK(tripcomputer_trip)
    DATA_PROERTY_CHECK(tripcomputer_trip_Average_Speed)
    if (tripcomputer_Vehicle_Running_time_H.isModified() || tripcomputer_Vehicle_Running_time_M.isModified()) {
        emit tripcomputer_Vehicle_Running_timeChanged();
    }
    if (tripcomputer_Vehicle_SYS_time_H.isModified() || tripcomputer_Vehicle_SYS_time_M.isModified()) {
        emit tripcomputer_systimeChanged();
    }
    if (tripcomputer_IP_FuelLevelPercent.isModified()) {
        emit tripcomputer_IP_FuelLevelPercentChanged();
        emit tripcomputer_DteChanged();
    }
}

DATA_PROPERTY_SIMPLE_IMPLEMENT(TripComputerDataModel, tripcomputer_Odo, unsigned int)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TripComputerDataModel, tripcomputer_AC_EnvironmentalTemp, unsigned int)
DATA_PROPERTY_SIMPLE_IMPLEMENT(TripComputerDataModel, tripcomputer_IP_FuelLevelPercent, unsigned int)
DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_trip, QString)
{
    return QString::number(tripcomputer_trip.getValue());
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_trip_Average_Speed, QString)
{
    return QString::number(tripcomputer_trip_Average_Speed.getValue());
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_Vehicle_Running_time, QString)
{
    return QTime(tripcomputer_Vehicle_Running_time_H.getValue(), tripcomputer_Vehicle_Running_time_M.getValue()).toString("hh:mm");
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_systime, QString)
{
    return QTime(tripcomputer_Vehicle_SYS_time_H.getValue(), tripcomputer_Vehicle_SYS_time_M.getValue()).toString("hh:mm");
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_Dte, unsigned int)
{
    return 600 * tripcomputer_IP_FuelLevelPercent.getValue() / 100;
}