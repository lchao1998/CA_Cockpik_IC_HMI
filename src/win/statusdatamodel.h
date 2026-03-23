#ifndef STATUSDATAMODEL_H
#define STATUSDATAMODEL_H

#include <datamodel.h>
#include <QString>

class StatusDataModel : public DataModel
{
    Q_OBJECT

public:
#ifdef SIMULATION
    explicit StatusDataModel(int updateInterval = 500, QObject *parent = nullptr);
#else
    explicit StatusDataModel(int updateInterval = 5000, QObject *parent = nullptr);
#endif

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(status_tripcomputer_menu, QString)
    DATA_PROPERTY_DEFINE(status_adas_status, QString)
    DATA_PROPERTY_DEFINE(status_navi_status, bool)

signals:
    CHANGED_SIGNAL_DEFINE(status_tripcomputer_menu)
    CHANGED_SIGNAL_DEFINE(status_adas_status)
    CHANGED_SIGNAL_DEFINE(status_navi_status)

private:
    int m_index;
    QString m_adas_status;
    bool m_navi_flag;
#ifdef SIMULATION
    int m_time_count;
#endif
    int m_adas_count;
};

#endif // STATUSDATAMODEL_H
