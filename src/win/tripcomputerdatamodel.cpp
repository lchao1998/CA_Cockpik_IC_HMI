#include "tripcomputerdatamodel.h"
#include <QDateTime>

TripComputerDataModel::TripComputerDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
      m_testval(0),
      m_odo_count(0),
      m_odo(0)
{
}

void TripComputerDataModel::updateData()
{
    if (++m_testval > 100) {
        m_testval = 0;
    }

    if (m_odo_count > 3) {
        m_odo++;
        m_odo_count = 0;
    } else {
        m_odo_count++;
    }

    emit tripcomputer_OdoChanged();
    emit tripcomputer_AC_EnvironmentalTempChanged();
    emit tripcomputer_tripChanged();
    emit tripcomputer_trip_Average_SpeedChanged();
    emit tripcomputer_Vehicle_Running_timeChanged();
    emit tripcomputer_IP_FuelLevelPercentChanged();
    emit tripcomputer_DteChanged();
    emit tripcomputer_systimeChanged();
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_Odo, unsigned int)
{
    return m_odo;
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_AC_EnvironmentalTemp, unsigned int)
{
    return 21;
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_trip, QString)
{
    return QString("300");
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_trip_Average_Speed, QString)
{
    return QString("80");
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_Vehicle_Running_time, QString)
{
    return QString("50:23");
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_IP_FuelLevelPercent, unsigned int)
{
    return (500 - (m_odo % 500)) / 5;
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_Dte, unsigned int)
{
    return 500 - (m_odo % 500);
}

DATA_PROPERTY_IMPLEMENT(TripComputerDataModel, tripcomputer_systime, QString)
{
    return QDateTime::currentDateTime().toString("hh:mm");
}
