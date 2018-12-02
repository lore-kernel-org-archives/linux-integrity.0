Return-Path: <SRS0=SF38=OL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EDC64EB4
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7152054F
	for <linux-integrity@archiver.kernel.org>; Sun,  2 Dec 2018 14:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7152054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLBOr6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 09:47:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbeLBOr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 09:47:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB2EhP6u058869
        for <linux-integrity@vger.kernel.org>; Sun, 2 Dec 2018 09:47:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p48adycvw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 02 Dec 2018 09:47:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 2 Dec 2018 14:47:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Dec 2018 14:47:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB2ElnjX51183658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Dec 2018 14:47:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F7452051;
        Sun,  2 Dec 2018 14:47:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.63])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F1AB052050;
        Sun,  2 Dec 2018 14:47:48 +0000 (GMT)
Subject: Re: [PATCH v2 5/7] ima-evm-utils: Preload OpenSSL engine via
 '--engine' option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 02 Dec 2018 09:47:31 -0500
In-Reply-To: <20181201030158.q6bck2wwtkezzpns@sole.flsd.net>
References: <20181128200610.21214-1-vt@altlinux.org>
         <20181128200610.21214-5-vt@altlinux.org>
         <1543605694.4216.72.camel@linux.ibm.com>
         <20181201030158.q6bck2wwtkezzpns@sole.flsd.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120214-0008-0000-0000-0000029BC009
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120214-0009-0000-0000-000022061569
Message-Id: <1543762051.4216.183.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=979 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812020142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2018-12-01 at 06:01 +0300, Vitaly Chikunov wrote:
> On Fri, Nov 30, 2018 at 02:21:34PM -0500, Mimi Zohar wrote:
> > On Wed, 2018-11-28 at 23:06 +0300, Vitaly Chikunov wrote:
> > 
> > > @@ -1773,6 +1776,7 @@ static char *get_password(void)
> > >  int main(int argc, char *argv[])
> > >  {
> > >  	int err = 0, c, lind;
> > > +	ENGINE *eng = NULL;
> > > 
> > >  	g_argv = argv;
> > >  	g_argc = argc;
> > > @@ -1883,6 +1887,18 @@ int main(int argc, char *argv[])
> > >  		case 138:
> > >  			measurement_list = 1;
> > >  			break;
> > > +		case 139: /* --engine e */
> > > +			eng = ENGINE_by_id(optarg);
> > 
> > The usage is only adding "--engine e" support.  Either change the
> > usage or add a test to verify the argument.
> 
> Could you elaborate what I should do? I didn't understand your
> suggestion.  User should be able to specify anything as engine name and
> it is tested by ENGINE_by_id call. Also, usage implies that it would
> load engine with the name e.

My mistake.  Could you update the patch description with example
usage?

Mimi

