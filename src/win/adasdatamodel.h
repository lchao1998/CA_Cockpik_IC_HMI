#ifndef ADASDATAMODEL_H
#define ADASDATAMODEL_H

#include "datamodel.h"

class AdasDataModel : public DataModel
{
    Q_OBJECT

public:
    explicit AdasDataModel(int updateInterval = 3000, QObject *parent = nullptr);

protected:
    void updateData() override;

    DATA_PROPERTY_DEFINE(adas_obstacle_on, bool)
    DATA_PROPERTY_DEFINE(adas_obstacle_x, int)
    DATA_PROPERTY_DEFINE(adas_obstacle_y, int)
    DATA_PROPERTY_DEFINE(adas_obstacle_image, QString)

signals:
    CHANGED_SIGNAL_DEFINE(adas_obstacle_on)
    CHANGED_SIGNAL_DEFINE(adas_obstacle_x)
    CHANGED_SIGNAL_DEFINE(adas_obstacle_y)
    CHANGED_SIGNAL_DEFINE(adas_obstacle_image)

private:
    bool m_wait;
    unsigned int m_count;
};

#endif // ADASDATAMODEL_H
