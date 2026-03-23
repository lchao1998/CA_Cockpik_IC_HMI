#ifndef TRIPCOMPUTERDATAMODEL_H
#define TRIPCOMPUTERDATAMODEL_H

#include <datamodel.h>
#include <QString>

class TripComputerDataModel : public DataModel
{
    Q_OBJECT
public:
    explicit TripComputerDataModel(int updateInterval = 200, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(tripcomputer_trip, QString)
    DATA_PROPERTY_DEFINE(tripcomputer_trip_Average_Speed, QString)
    DATA_PROPERTY_DEFINE(tripcomputer_Vehicle_Running_time, QString)
    DATA_PROPERTY_DEFINE(tripcomputer_Odo, unsigned int)
    DATA_PROPERTY_DEFINE(tripcomputer_AC_EnvironmentalTemp, unsigned int)
    DATA_PROPERTY_DEFINE(tripcomputer_IP_FuelLevelPercent, unsigned int)
    DATA_PROPERTY_DEFINE(tripcomputer_Dte, unsigned int)
    DATA_PROPERTY_DEFINE(tripcomputer_systime, QString)

signals:
    CHANGED_SIGNAL_DEFINE(tripcomputer_trip)
    CHANGED_SIGNAL_DEFINE(tripcomputer_trip_Average_Speed)
    CHANGED_SIGNAL_DEFINE(tripcomputer_Vehicle_Running_time)
    CHANGED_SIGNAL_DEFINE(tripcomputer_Odo)
    CHANGED_SIGNAL_DEFINE(tripcomputer_AC_EnvironmentalTemp)
    CHANGED_SIGNAL_DEFINE(tripcomputer_IP_FuelLevelPercent)
    CHANGED_SIGNAL_DEFINE(tripcomputer_Dte)
    CHANGED_SIGNAL_DEFINE(tripcomputer_systime)
};

#endif // TRIPCOMPUTERDATAMODEL_H
