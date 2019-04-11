Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5292C10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931C02133D
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 12:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfDKMWk (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:22:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfDKMWj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 08:22:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BCK1Fe012711
        for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2019 08:22:38 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt4xc25jy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2019 08:22:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Apr 2019 13:22:35 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 13:22:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BCMUlm51970146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 12:22:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE03AE055;
        Thu, 11 Apr 2019 12:22:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2ADEAE045;
        Thu, 11 Apr 2019 12:22:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 12:22:29 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh
 cleanup
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 11 Apr 2019 08:22:19 -0400
In-Reply-To: <20190411055114.GA23472@x230>
References: <20190405165225.27216-1-pvorel@suse.cz>
         <20190405165225.27216-2-pvorel@suse.cz>
         <1554944374.25614.25.camel@linux.ibm.com> <20190411055114.GA23472@x230>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041112-0028-0000-0000-0000035FBADC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041112-0029-0000-0000-0000241EE165
Message-Id: <1554985339.7843.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110086
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-11 at 07:51 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> thanks for your comments.
> 
> ...
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -20,7 +20,8 @@
> > >  TST_TESTFUNC="test"
> > >  TST_SETUP_CALLER="$TST_SETUP"
> > >  TST_SETUP="ima_setup"
> > > -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> > > +TST_CLEANUP_CALLER="$TST_CLEANUP"
> > > +TST_CLEANUP="ima_cleanup"
> 
> > It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> > defining the respective _CALLER looks strange.  The _CALLER's string
> > must be empty.
> TST_{SETUP,CALLER}_CALLER takes setup from the test.
> It's IMHO cleaner way allowing tests to set their setup/cleanup functions and
> not care that there is also some library setup/cleanup (kind of encapsulation).

I'm not questioning the method for initializing this test.  I guess
I'm asking why bother to set TST_{SETUP,CLEANUP}_CALLER this way, if
we know that it isn't set.  Why not just initialize it as ""?

Mimi
> 
> We already used this for setup, I wanted to have a same approach for both setup
> and cleanup. Sure I can instead add ima_setup/ima_cleanup into tests' setup/cleanup
> functions, but both solutions are working and I consider encapsulation as a benefit.
> The only problematic thing would be if some test needed to run it's custom
> cleanup *before* library one while other tests *after*. But that's not a case here.
> We also use this approach in tst_net.sh [1].
> 
> > >  TST_NEEDS_TMPDIR=1
> > >  TST_NEEDS_ROOT=1
> 
> > > @@ -95,6 +96,9 @@ ima_setup()
> > >  ima_cleanup()
> > >  {
> > >  	local dir
> > > +
> > > +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> > > +
> 
> > Is something else setting TST_CLEANUP_CALLER?
> 
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_net.sh#L11
> 

