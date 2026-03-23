#ifndef STATUSDATAMODEL_H
#define STATUSDATAMODEL_H

#include <datamodel.h>

class StatusDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit StatusDataModel(int updateInterval = 200, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(status_tripcomputer_menu, QString)
    DATA_PROPERTY_DEFINE(status_adas_status, QString)
    DATA_PROPERTY_DEFINE(status_navi_status, bool)

signals:
    CHANGED_SIGNAL_DEFINE(status_tripcomputer_menu)
    CHANGED_SIGNAL_DEFINE(status_adas_status)
    CHANGED_SIGNAL_DEFINE(status_navi_status)
};

#endif // STATUSDATAMODEL_H
