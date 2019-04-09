Return-Path: <SRS0=XIeY=SL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6517DC10F0E
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336FB2084F
	for <linux-integrity@archiver.kernel.org>; Tue,  9 Apr 2019 12:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDIMcX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbfDIMcX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Apr 2019 08:32:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39CLWEC020027
        for <linux-integrity@vger.kernel.org>; Tue, 9 Apr 2019 08:32:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rrs0qydvj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Apr 2019 08:32:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Apr 2019 13:32:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 13:32:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39CWE8q51249194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 12:32:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90E214C046;
        Tue,  9 Apr 2019 12:32:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1CAF4C052;
        Tue,  9 Apr 2019 12:32:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.143])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 12:32:13 +0000 (GMT)
Subject: Re: appraisal reset safety
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 09 Apr 2019 08:32:03 -0400
In-Reply-To: <CAE=NcrbSpC3htW5BhZth8OuSGM-DVtH67i=uWg9tosJKv3Sg9g@mail.gmail.com>
References: <CAE=Ncrbk9-FLbGYKawdu62iDNKD-HH1QaDC+aDZAWPcf=17R7A@mail.gmail.com>
         <CAE=NcrbR+TzNJ0xqf_ZSPOsm+J+Lbnxi8MMVy_9_2KfdpocgQA@mail.gmail.com>
         <CAE=NcrYc3qXU2Y2BWJhbh0kTrCZN9AVmSmz6msqTKTNZR+iBPQ@mail.gmail.com>
         <1554729047.17244.95.camel@linux.ibm.com>
         <CAE=NcrZ67AGtHmWQF2HOF1i5LG4idrHx1q+83tzG4knpNBCQFA@mail.gmail.com>
         <CAE=Ncraz_sDhtmE2RPYxJmo+yRkRK5opDyburk126sCSW-MvbQ@mail.gmail.com>
         <1554811489.4192.15.camel@linux.ibm.com>
         <CAE=NcrbSpC3htW5BhZth8OuSGM-DVtH67i=uWg9tosJKv3Sg9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040912-0020-0000-0000-0000032DE8A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040912-0021-0000-0000-000021800EC6
Message-Id: <1554813123.4192.33.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090079
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-04-09 at 15:25 +0300, Janne Karhunen wrote:
> On Tue, Apr 9, 2019 at 3:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > > It would take an additional integrity hook, of course.
> >
> > That's fine.
> 
> Great, I will work up a proper patch and check the locking.

Thanks!

Mimi

