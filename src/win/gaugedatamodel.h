#ifndef GAUGEDATAMODEL_H
#define GAUGEDATAMODEL_H

#include <datamodel.h>
#include <QString>
#include <QProcessEnvironment>

class GaugeDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit GaugeDataModel(int updateInterval = 50, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(gauge_ESP_VehicleSpeed, int)
    DATA_PROPERTY_DEFINE(gauge_EMS_EngineSpeed, double)
    DATA_PROPERTY_DEFINE(gauge_TCU_GearForDisplay, QString)
    DATA_PROPERTY_DEFINE(gauge_SpecialEffects_Switch, int)//特效开关，0：表示关闭，1：表示开启

signals:
    CHANGED_SIGNAL_DEFINE(gauge_ESP_VehicleSpeed)
    CHANGED_SIGNAL_DEFINE(gauge_EMS_EngineSpeed)
    CHANGED_SIGNAL_DEFINE(gauge_TCU_GearForDisplay)
    CHANGED_SIGNAL_DEFINE(gauge_SpecialEffects_Switch)

private:
    //for test
    unsigned int m_testvspeed;
    unsigned int m_testespeed;
    unsigned int m_gear_index;
    unsigned int m_count;
    QString m_specialeffects_switch;
};

#endif // GAUGEDATAMODEL_H
