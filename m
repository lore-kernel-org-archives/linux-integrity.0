Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE569C282C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1C1217D9
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 15:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfBLPmG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:42:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfBLPmG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Feb 2019 10:42:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CFduis107438
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 10:42:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qm0m71be2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Feb 2019 10:42:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Feb 2019 15:42:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 15:41:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CFfwIp52363396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 15:41:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79E5BA405B;
        Tue, 12 Feb 2019 15:41:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32B3A4054;
        Tue, 12 Feb 2019 15:41:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.85])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Feb 2019 15:41:57 +0000 (GMT)
Subject: Re: [PATCH v3 7/7] ima-evm-utils: Try to load digest by its alias
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 12 Feb 2019 10:41:46 -0500
In-Reply-To: <20190211203718.gx6iw3d2vhikegdy@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
         <20181203033525.20431-7-vt@altlinux.org>
         <1549906738.12743.167.camel@linux.ibm.com>
         <20190211175248.22ighzenzvm5tddb@altlinux.org>
         <1549907952.12743.173.camel@linux.ibm.com>
         <20190211181300.cktmpuymd4uqtcov@altlinux.org>
         <20190211182115.gir76jn66e73akc7@altlinux.org>
         <20190211192644.q7ipos4rrmj7vugq@altlinux.org>
         <1549916463.12743.188.camel@linux.ibm.com>
         <20190211203718.gx6iw3d2vhikegdy@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021215-0028-0000-0000-00000347B55B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021215-0029-0000-0000-00002405D5CA
Message-Id: <1549986106.12743.260.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-02-11 at 23:37 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Feb 11, 2019 at 03:21:03PM -0500, Mimi Zohar wrote:
> > On Mon, 2019-02-11 at 22:26 +0300, Vitaly Chikunov wrote:
> > > On Mon, Feb 11, 2019 at 09:21:15PM +0300, Vitaly Chikunov wrote:
> > > > On Mon, Feb 11, 2019 at 09:13:00PM +0300, Vitaly Chikunov wrote:
> > > > > On Mon, Feb 11, 2019 at 12:59:12PM -0500, Mimi Zohar wrote:
> > > > > > On Mon, 2019-02-11 at 20:52 +0300, Vitaly Chikunov wrote:
> > > > > > > On Mon, Feb 11, 2019 at 12:38:58PM -0500, Mimi Zohar wrote:
> > > > > > > > On Mon, 2018-12-03 at 06:35 +0300, Vitaly Chikunov wrote:
> > > > > > > > > For compatibility with older OpenSSL try to load digest by its alias if
> > > > > > > > > load by its proper name is failed.
> > > > > > > > > 
> > > > > > > > > This is configured in pkey_hash_algo by mentioning loadable alias first in the
> > > > > > > > > comma separated list of algo names.
> > > > > > > > 
> > > > > > > > After this patch, I can not verify the signature.  It's failing to
> > > > > > > > find the hash algorithm.
> > > > > > > 
> > > > > > > Yes, it's fixed in "ima-evm-utils: convert sign v2 from RSA to EVP_PKEY
> > > > > > > API". I didn't consider it a problem since streebog256 should not work
> > > > > > > for sign/verify anyway (since RSA should not support it). That EVP_PKEY
> > > > > > > patch which adds ability to sign/verify for Streebog also fixes above
> > > > > > > problem.
> > > > > > 
> > > > > > I've been having second thoughts about this patch in general, as it
> > > > > > made the hash algorithm comparison unnecessarily more complex for the
> > > > > > simple case.  As there hasn't been a new ima-evm-utils release with
> > > > > > patch, perhaps we should simple remove/revert it?
> > > > > 
> > > > > It was only for compatibility with older openssl/gost-engine, where
> > > > > "streebog256" name is not defined yet. If you don't want to allow that
> > > > > users to use Streebog feel free to revert it.
> > > 
> > > Or you may suggest simpler approach.
> > > 
> > > Basically, we need to resole both text strings into the same PKEY_HASH_
> > > id, allow any of the string pass into EVP_get_digestbyname, and resolve
> > > PKEY_HASH_ id back into the correct hash name. Optionally, allow user to
> > > specify new hash name on older openssl/gost-engine. This is all
> > > implemented by that patch, it was not just overly complicated "hash
> > > algorithm comparison".
> > > 
> > > My wish is we retain support of older openssl/gost-engine.
> > 
> > The following seems to fix the problem, but instead of adding it in
> > strmatch(), as below, I would add it before the strmatch() call.  Then
> > strmatch is only called as needed.
> 
> IC.

The patch below isn't addressing old vs. new naming, but fixes
"ima_verify".  Adding the following line, results in "strmatch: algo
md_gost12_256,streebog256".  It's trying to match the entire string,
but fails without the strcmp().

+       log_info("strmatch: algo %s \n", needle);

Mimi


> I will try to conceptually simplify the code and prepare another
> patch. Probably, I will split pkey_hash_algop[] into two arrays, simple
> one where strcmp() in the loop is used, and complex one for hash names
> with aliases. I will try to replace strmatch() with just simple string 
> array loop.
> 
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index d9ffa13befb0..7901215da655 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -598,6 +598,9 @@ static int strmatch(const char *needle, const char *haystack)
> >         const char *p = haystack;
> >         const char *t;
> >  
> > +       if (strcmp(needle, haystack) == 0)
> > +               return 0;
> > +
> >         for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
> >                 if (t - p == len &&
> >                     !strncmp(needle, p, len))
> > 
> > Mimi
> 

