#ifndef GAUGEDATAMODEL_H
#define GAUGEDATAMODEL_H

#include "datamodel.h"
#include <QString>
#include <QProcessEnvironment>

class GaugeDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit GaugeDataModel(int updateInterval = 200, QObject *parent = nullptr);

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
    QString m_specialeffects_switch;
};

#endif // GAUGEDATAMODEL_H
