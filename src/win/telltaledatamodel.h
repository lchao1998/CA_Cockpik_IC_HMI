#ifndef TELLTALEDATAMODEL_H
#define TELLTALEDATAMODEL_H

#include <datamodel.h>

class TelltaleDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit TelltaleDataModel(int updateInterval = 1500, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(telltale_EMS_CoolanTemperatureError, bool)
    DATA_PROPERTY_DEFINE(telltale_EMS_OilPressureSts, bool)
    DATA_PROPERTY_DEFINE(telltale_EMS_SVS, bool)
    DATA_PROPERTY_DEFINE(telltale_EMS_MIL, bool)
    DATA_PROPERTY_DEFINE(telltale_ESP_ABSFailStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_SRS_WarningLampStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_SRS_BuckleSwitchStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_TCU_TransFailureStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_EPB_FunctionLamp, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_BatteryStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_DoorStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_HighBeamStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_LowBeamStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_TurnIndicatorRight, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_TurnIndicatorLeft, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_RearFoglampStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_FrontFoglampStatus, bool)
    DATA_PROPERTY_DEFINE(telltale_BCM_PositionLampStatus, bool)

signals:
    CHANGED_SIGNAL_DEFINE(telltale_EMS_CoolanTemperatureError)
    CHANGED_SIGNAL_DEFINE(telltale_EMS_OilPressureSts)
    CHANGED_SIGNAL_DEFINE(telltale_EMS_SVS)
    CHANGED_SIGNAL_DEFINE(telltale_EMS_MIL)
    CHANGED_SIGNAL_DEFINE(telltale_ESP_ABSFailStatus)
    CHANGED_SIGNAL_DEFINE(telltale_SRS_WarningLampStatus)
    CHANGED_SIGNAL_DEFINE(telltale_SRS_BuckleSwitchStatus)
    CHANGED_SIGNAL_DEFINE(telltale_TCU_TransFailureStatus)
    CHANGED_SIGNAL_DEFINE(telltale_EPB_FunctionLamp)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_BatteryStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_DoorStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_HighBeamStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_LowBeamStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_TurnIndicatorRight)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_TurnIndicatorLeft)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_RearFoglampStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_FrontFoglampStatus)
    CHANGED_SIGNAL_DEFINE(telltale_BCM_PositionLampStatus)

private:
    void timeout_FunctionLamp();

    QTimer* m_FunctionLamp_timer;
    bool m_FunctionLamp_value;
    unsigned int m_index;
    bool m_switch;
};

#endif // TELLTALEDATAMODEL_H
