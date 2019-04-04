Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A96C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423E02075E
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfDDTTp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:19:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbfDDTTp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 15:19:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34JJbuY022283
        for <linux-integrity@vger.kernel.org>; Thu, 4 Apr 2019 15:19:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rnqmkh0b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Apr 2019 15:19:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Apr 2019 20:19:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 20:19:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34JJN0P56819950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 19:19:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED2A42049;
        Thu,  4 Apr 2019 19:19:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A4E42047;
        Thu,  4 Apr 2019 19:19:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 19:19:22 +0000 (GMT)
Subject: Re: [PATCH 3/3] ima: Add overlay test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Weihua Du <WHDu@suse.com>, linux-integrity@vger.kernel.org
Date:   Thu, 04 Apr 2019 15:19:12 -0400
In-Reply-To: <20190404181901.GA22718@dell5510>
References: <20190327161638.7407-1-pvorel@suse.cz>
         <20190327161638.7407-4-pvorel@suse.cz>
         <1553856587.9420.44.camel@linux.ibm.com> <20190404181901.GA22718@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040419-4275-0000-0000-000003245D8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040419-4276-0000-0000-000038336A97
Message-Id: <1554405552.3839.41.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-04 at 20:19 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> thanks for your comments!
> 
> > > +	grep -q ima_appraise_tcb /proc/cmdline || \
> > > +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"
> 
> > Instead of specifying individual policies separately, the newer method
> > of specifying builtin IMA policies on the boot command line is
> > "ima_policy=", with a list of policies.  The builtin appraise policy
> > would be specified as "ima_policy=appraise_tcb".  Refer to
> > Documentation/admin-guide/kernel-parameters.txt for the list of
> > builtin policies.
> I guess grep for any policy (ima_policy=) or ima_appraise_tcb shold e enough.
> Am I right?

Yes

> 
> BTW I guess ima_appraise_tcb should be deprecated in kernel-parameters.txt.

and yes

> 
> > > +}
> > > +
> > > +do_test()
> > > +{
> > > +	local file="foo.txt"
> > > +	local f
> > > +
> > > +	tst_mount
> > > +	mounted=1
> > > +
> > > +	ROD echo lower \> $lower/$file
> 
> > For some reason "mntpoint/lower" isn't loopback mounted.  With the
> > builtin appraise policy, because it is a tmpfs filesystem,
> > security.ima does not exist.  Writing to the merged directory then
> > fails.
> 
> > + df -T mntpoint/lower
> > Filesystem     Type  1K-blocks   Used Available Use% Mounted on
> > tmpfs          tmpfs   4020348 262316   3758032   7% /tmp
> My bad, I forged to add TST_NEEDS_DEVICE=1 to ima_overlay.sh (I'll add it into
> v2). That was the missing piece to enable loop device (in the end of ima_setup.sh)

thanks!
> 
> 
> > + getfattr -m '^security' --dump mntpoint/lower/foo.txt
> > # file: mntpoint/lower/foo.txt
> > security.evm=0sAq8niNi4X7cYntKSAki1Woc+Y5Yq
> > security.selinux="unconfined_u:object_r:user_tmp_t:s0"
> 
> 
> Kind regards,
> Petr
> 

